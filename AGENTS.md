# Repository Guidelines

## Project Structure & Module Organization

This repository stores editor and terminal dotfiles. Each top-level directory maps to a tool's installed config location:

- `nvim/` -> `~/.config/nvim/` with `init.lua`, `lua/config/lazy.lua`, and plugin specs in `lua/plugins/`
- `helix/` -> `~/.config/helix/` with `config.toml` and `languages.toml`
- `alacritty/` -> `~/.config/alacritty/`
- `tmux/` -> `~/.tmux.conf` plus `tmux/macos/tmux.conf` for macOS overrides
- `zellij/` -> `~/.config/zellij/config.kdl`

Keep new files near the tool they configure. Prefer one Neovim plugin spec per file under `nvim/lua/plugins/`.
