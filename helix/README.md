# Helix setup

## Installation

### Fedora
```bash
sudo dnf install helix
```

### Ubuntu
```bash
sudo add-apt-repository ppa:maveonair/helix-editor
sudo apt update
sudo apt install helix
```

## Configure helix
- Install `pipx`
- Install `pyright`: `pipx install pyright`
- Copy `languages.toml` and `config.toml` to `~/.config/helix/`
- Set helix your default editor: `hx ~/.bashrc`, add `export EDITOR=hx`

## Other tools
`tmux`:
- copy `_tmux.conf` to `~/.tmux.conf`
- for WSL, switch the clipboard keymap to `bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel "clip.exe"`

`rg`:
- https://github.com/BurntSushi/ripgrep

`uv`:
- https://github.com/astral-sh/uv

`nnn`:
- https://github.com/jarun/nnn

`lazygit`:
- https://github.com/jesseduffield/lazygit

`delta`:
- https://github.com/dandavison/delta
- Add below lines to `~/.gitconfig`:
```
[core]
    pager = delta
    editor = hx

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true  # use n and N to move between diff sections
    dark = true      # or light = true, or omit for auto-detection
    side-by-side = true
    line-numbers = true

[merge]
    conflictstyle = zdiff3  
```

## Terminal fonts

Link: https://www.nerdfonts.com/font-downloads

Recommended font: `JetBrainsMono Nerd Font`
