# nnn setup

`nnn` is a terminal file manager: https://github.com/jarun/nnn

This directory holds `quitcd.sh`, a shell wrapper that makes your shell follow
`nnn` to whatever directory you were browsing when you quit. Unlike the other
directories in this repo, it does not map to `~/.config/nnn/` — it is sourced
from your shell rc.

## Installation

### Fedora
```bash
sudo dnf install nnn
```

Then add this to `~/.bashrc` (works the same in `~/.zshrc`):
```bash
. "$HOME/code/vimrc/nnn/quitcd.sh"
```

Reload with `source ~/.bashrc` or open a new shell. Browse with `n`, quit with
`q`, and the shell stays in the directory you left off in.

## How it works

A child process cannot change its parent shell's directory, so every
"cd on quit" file manager works the same way: the child writes its final
directory to a file, and a shell *function* in the parent reads that file and
does the `cd` itself. It has to be a function, not a script — a script runs in
its own subshell and its `cd` dies with it.

`nnn` exposes this through the `NNN_TMPFILE` environment variable. When it is
set, `nnn` always cds on quit: it writes a ready-made shell command to that
path, so the wrapper sources the file instead of parsing it.

```bash
$ NNN_TMPFILE=/tmp/lastd nnn        # browse to ~/code/vimrc, press q
$ cat /tmp/lastd
cd '/home/krza/code/vimrc'
```

The rest of the function is guard rails:

- **`[ "${NNNLVL:-0}" -eq 0 ]`** — `nnn` sets `NNNLVL` while running, and can
  spawn a shell from inside itself (`!`). Without this check, typing `n` in
  that spawned shell nests a second `nnn` inside the first, and quitting
  unwinds through both.
- **`command nnn`** — bypasses the `nnn` alias so the function is safe even if
  you later alias `nnn` to `n`. The cost is that alias flags are skipped, which
  is why `-C` is repeated here; keep the two in sync if you change them.
- **`local NNN_TMPFILE=...` plus `export`** — `local` keeps the variable
  scoped to the function so it does not leak into the interactive shell,
  while `export` still puts it in `nnn`'s environment.
- **`[ -s ... ]`** — only source the file if it is non-empty, so an `nnn` that
  crashed before writing does not produce a stray error.

`mktemp` is used instead of `nnn`'s documented fixed path (`/tmp/.lastd`) so
that concurrent shells cannot read each other's last directory.

## Flags used

Set in `quitcd.sh`:

- `NNN_OPTS="de"` — `d`: start in detail mode; `e`: open text files in
  `$VISUAL` (falling back to `$EDITOR`, then `vi`).
- `-C` — 8-color scheme: color directories by context, disable file colors.

## Related

The same pattern for `yazi`, which takes an explicit `--cwd-file` and writes a
bare path rather than a command, so the wrapper reads it into a variable:

```bash
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
```
