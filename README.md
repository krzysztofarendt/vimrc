# Dotfiles

My terminal and editor configs.
The daily driver is alacritty + [Runyte](https://runyte.com).
Other configs are kept for when I need them.

## Layout

| Directory    | Installed to                                         |
| ------------ | ---------------------------------------------------- |
| `tmux/`      | `~/.tmux.conf` (copy `tmux_dark.conf` or `tmux_light.conf`) |
| `alacritty/` | `~/.config/alacritty/` (`macos/` holds the macOS variant) |
| `helix/`     | `~/.config/helix/` — see [`helix/README.md`](helix/README.md) |
| `nvim/`      | `~/.config/nvim/`                                    |
| `nnn/`       | sourced from `~/.bashrc` — see [`nnn/README.md`](nnn/README.md) |

## Arch Linux

```bash
sudo pacman -S tmux ripgrep uv nnn lazygit git-delta alacritty
```

Editors and language tooling (only if using Helix or Neovim):
```bash
sudo pacman -S helix neovim tree-sitter-cli pyright ruff rust-analyzer python-black python-pipx
```

Arch installs Helix as `helix`, not `hx`. Add an alias so `hx` (used below and
in the delta config) works:
```bash
alias hx=helix
```

### Fonts

Install JetBrains Mono Nerd Font:

```sh
sudo pacman -S ttf-jetbrains-mono-nerd
```

## Fedora

```bash
sudo dnf install tmux ripgrep uv nnn git-delta alacritty
sudo dnf install helix neovim
```

`lazygit` is not in the Fedora repos — see https://github.com/jesseduffield/lazygit
for install options.

### Fonts

Download `JetBrainsMono Nerd Font` from https://www.nerdfonts.com/font-downloads
and extract it to `~/.local/share/fonts/`, then run `fc-cache -f`.

## Tools

### tmux
- Copy `tmux/tmux_dark.conf` or `tmux/tmux_light.conf` to `~/.tmux.conf`
- For WSL, switch the clipboard keymap to
  `bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel "clip.exe"`

### Alacritty
The configs import a theme from the
[alacritty-theme](https://github.com/alacritty/alacritty-theme) repo:
```bash
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
```

### nnn
Add to `~/.bashrc` to get the `n` cd-on-quit wrapper:
```bash
. "$HOME/code/vimrc/nnn/quitcd.sh"
```

### delta
Add to `~/.gitconfig`:
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

### Default editor
In `~/.bashrc`:
```bash
export EDITOR=hx
export VISUAL=hx
```

## Links

- Runyte: https://runyte.com
- tmux: https://github.com/tmux/tmux
- Helix: https://helix-editor.com/
- Neovim: https://neovim.io/
- ripgrep: https://github.com/BurntSushi/ripgrep
- uv: https://github.com/astral-sh/uv
- nnn: https://github.com/jarun/nnn
- lazygit: https://github.com/jesseduffield/lazygit
- delta: https://github.com/dandavison/delta
- Nerd Fonts: https://www.nerdfonts.com/font-downloads
