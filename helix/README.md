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

## Configuration

- Install `pipx`
- Install `pyright`: `pipx install pyright`
- Copy `languages.toml` and `config.toml` to `~/.config/helix/`
- Run Helix: `hx`

## Other tools

tmux:
- copy `_tmux.conf` to `~/.tmux.conf`

lazygit:
- https://github.com/jesseduffield/lazygit

rg:
- https://github.com/BurntSushi/ripgrep

uv:
- https://github.com/astral-sh/uv
