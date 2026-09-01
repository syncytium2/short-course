#!/usr/bin/env python3
# instrument: verification
"""Audit ~/Developer ON THE MACHINE THIS RUNS ON: which hooks are installed, registered, able to fire.

SCOPE, because the first write-up of this got it wrong: this sees one disk. It takes no host
argument and cannot reach another machine, so "8 of 18 repos" means 8 of the 18 checkouts that
happen to be here. Repos whose real work lives on other machines -- interface2 is done on lab
workstations -- are represented by whatever cold copy is on this laptop, which says nothing
about the gates in force where the work actually happens. Run it there too, or say "on this
machine" every time you quote a number from it.


Read-only. The question it answers is not "is the file there" but "can it refuse".
Three distinct ways a hook is present and dead:
  ORPHAN    on disk, not registered in any settings.json -> never runs
  GHOST     registered in settings.json, not on disk     -> turnstile prints, allows
  ADVISORY  registered via turnstile, no `# turnstile: gate` line -> exits 2, overruled
"""
import json, os, re, glob

DEV = os.path.expanduser("~/Developer")
DECL = re.compile(r"^#[ \t]*turnstile:[ \t]*([a-z0-9 ]*[a-z0-9])[ \t]*$", re.M)
HOOKPATH = re.compile(r"[\w./-]*\.claude/hooks/[\w.-]+\.sh|[\w./-]*tools/[\w.-]*hook[\w.-]*\.sh")


def settings_files(repo):
    out = []
    for n in ("settings.json", "settings.local.json"):
        p = os.path.join(repo, ".claude", n)
        if os.path.isfile(p):
            out.append(p)
    return out


def registered(repo):
    """{hook_path_as_written: {'via_turnstile': bool, 'event': str, 'settings': str}}"""
    reg = {}
    for sf in settings_files(repo):
        try:
            data = json.load(open(sf))
        except Exception as e:
            reg["<<UNPARSEABLE %s: %s>>" % (os.path.basename(sf), e)] = {
                "via_turnstile": False, "event": "?", "settings": os.path.basename(sf)}
            continue
        for event, entries in (data.get("hooks") or {}).items():
            for entry in entries or []:
                for h in (entry.get("hooks") or []):
                    cmd = h.get("command", "")
                    m = HOOKPATH.findall(cmd)
                    for path in m:
                        reg[path] = {"via_turnstile": "turnstile-run" in cmd,
                                     "event": event,
                                     "settings": os.path.basename(sf)}
    return reg


def on_disk(repo):
    found = set()
    for pat in (".claude/hooks/*.sh", "tools/*hook*.sh"):
        for p in glob.glob(os.path.join(repo, pat)):
            if p.endswith(".selftest.sh"):
                continue
            found.add(os.path.relpath(p, repo))
    return found


def declares_gate(path):
    try:
        return "gate" in DECL.findall(open(path, errors="replace").read())
    except Exception:
        return False


rows = []
for repo in sorted(glob.glob(os.path.join(DEV, "*"))):
    name = os.path.basename(repo)
    if not os.path.isdir(os.path.join(repo, ".git")):
        continue
    if name.endswith("-worktrees"):
        continue

    reg = registered(repo)
    disk = on_disk(repo)
    has_turnstile = os.path.isfile(os.path.join(repo, "tools/turnstile/turnstile-run"))

    problems, ok = [], []
    reg_basenames = set()
    for path, info in reg.items():
        if path.startswith("<<"):
            problems.append(("BROKEN-SETTINGS", path))
            continue
        reg_basenames.add(os.path.basename(path))
        full = os.path.join(repo, path)
        if not os.path.isfile(full):
            problems.append(("GHOST", path + "  (registered, not on disk)"))
        elif info["via_turnstile"] and not declares_gate(full):
            problems.append(("ADVISORY", path + "  (turnstile-wrapped, no gate line)"))
        else:
            ok.append(os.path.basename(path))

    for d in sorted(disk):
        if os.path.basename(d) not in reg_basenames:
            problems.append(("ORPHAN", d + "  (on disk, registered nowhere)"))

    rows.append({"name": name, "turnstile": has_turnstile, "ok": sorted(ok),
                 "problems": problems,
                 "heredoc": "no-heredoc-source.sh" in reg_basenames,
                 "nhs_disk": any("no-heredoc" in d for d in disk)})

W = max(len(r["name"]) for r in rows)
print("\n%-*s  %-9s %-9s  %s" % (W, "repo", "turnstile", "heredoc", "live gates"))
print("-" * (W + 46))
for r in rows:
    hd = "WIRED" if r["heredoc"] else ("on-disk" if r["nhs_disk"] else "—")
    print("%-*s  %-9s %-9s  %s" % (
        W, r["name"], "yes" if r["turnstile"] else "—", hd,
        ", ".join(r["ok"]) or "(none)"))

print("\n\nPROBLEMS\n" + "=" * 60)
any_p = False
for r in rows:
    if r["problems"]:
        any_p = True
        print("\n%s" % r["name"])
        for kind, detail in r["problems"]:
            print("  %-16s %s" % (kind, detail))
if not any_p:
    print("none")

print("\n\nCOVERAGE\n" + "=" * 60)
n = len(rows)
print("repos scanned                     %d" % n)
print("with turnstile vendored           %d" % sum(1 for r in rows if r["turnstile"]))
print("with no-heredoc REGISTERED        %d" % sum(1 for r in rows if r["heredoc"]))
print("with no-heredoc on disk only      %d" % sum(1 for r in rows if r["nhs_disk"] and not r["heredoc"]))
print("with NO no-heredoc at all         %d" % sum(1 for r in rows if not r["nhs_disk"]))
