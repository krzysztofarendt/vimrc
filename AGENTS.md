# Repository Guidelines

## Project Structure & Module Organization

This repository stores editor and terminal dotfiles. Each top-level directory maps to a tool's installed config location:

- `tmux/` -> `~/.tmux.conf` (copy either `tmux_dark.conf` or `tmux_light.conf`)
- `alacritty/` -> `~/.config/alacritty/` (`macos/` holds the macOS variant)
- `helix/` -> `~/.config/helix/` with `config.toml` and `languages.toml`
- `nvim/` -> `~/.config/nvim/` with `init.lua`, `lua/config/lazy.lua`, and plugin specs in `lua/plugins/`
- `nnn/` -> sourced from `~/.bashrc`, not a config directory

Keep new files near the tool they configure. Prefer one Neovim plugin spec per file under `nvim/lua/plugins/`.

Per-OS install steps (Arch, Fedora) live in the top-level `README.md`; tool READMEs cover only tool-specific setup.
