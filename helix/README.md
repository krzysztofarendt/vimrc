# Helix setup

Package installs for Arch and Fedora are in the [main README](../README.md).

## Installation on Ubuntu
```bash
sudo add-apt-repository ppa:maveonair/helix-editor
sudo apt update
sudo apt install helix
```

## Configure helix
- Language tooling used by `languages.toml`:
  - `pyright` (Python LSP): `pipx install pyright`
  - `black` (Python formatter): `pipx install black`
  - `mdformat` (Markdown formatter): `pipx install mdformat`
- Copy `languages.toml` and `config.toml` to `~/.config/helix/`

On Arch, `pyright` and `black` come from pacman (see the main README); only
`mdformat` needs `pipx`.
