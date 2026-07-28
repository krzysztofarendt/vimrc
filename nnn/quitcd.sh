# nnn config + cd-on-quit wrapper. Source this from ~/.bashrc (bash or zsh):
#     . "$HOME/code/vimrc/nnn/quitcd.sh"
# See README.md in this directory for how it works.

export NNN_OPTS="de"
alias nnn="nnn -C"

n() {
	# Block nesting of nnn in subshells
	[ "${NNNLVL:-0}" -eq 0 ] || {
		echo "nnn is already running"
		return
	}

	# nnn writes a `cd '<lastdir>'` line here on quit
	local NNN_TMPFILE="$(mktemp -t "nnn-cwd.XXXXXX")"
	export NNN_TMPFILE
	command nnn -C "$@"
	[ -s "$NNN_TMPFILE" ] && . "$NNN_TMPFILE"
	rm -f -- "$NNN_TMPFILE"
	unset NNN_TMPFILE
}
