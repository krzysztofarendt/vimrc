# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal dotfiles repository containing configuration for multiple terminal tools. There is no build system, test suite, or package manager — changes are deployed by copying/symlinking files to their expected locations.

## Repository layout

- `nvim/` — Neovim config (Lua). Entry point is `nvim/init.lua`, which loads `lua/config/lazy.lua` (lazy.nvim plugin manager) and then configures keymaps, LSP, treesitter, and plugins. Plugin specs live in `nvim/lua/plugins/` as individual files auto-imported by lazy.nvim.
- `helix/` — Helix editor config (`config.toml` for theme, keybindings, and editor settings; `languages.toml` for LSP/formatter settings).
- `alacritty/` — Alacritty terminal config (`alacritty.toml`).
- `tmux/` — tmux config (`tmux.conf`). Uses vim-style navigation, Wayland clipboard (`wl-copy`), and activity/silence monitoring for coding agent windows.
- `zellij/` — Zellij terminal multiplexer config (`config.kdl`). Uses `Ctrl b` as the prefix key with locked default mode.

## Deployment

Config files are meant to be copied or symlinked to their standard locations:
- `nvim/` → `~/.config/nvim/`
- `helix/` → `~/.config/helix/`
- `alacritty/` → `~/.config/alacritty/`
- `tmux/tmux.conf` → `~/.tmux.conf`
- `zellij/config.kdl` → `~/.config/zellij/config.kdl`

## Key conventions

- Neovim leader key is `<Space>`.
- Tabs are 4 spaces (Neovim enforces this via `tabstop`/`shiftwidth`/`expandtab`).
- Active colorscheme is `onedark` in Neovim and Zellij; Helix uses `papercolor-light`.
- Clipboard integration targets Wayland (`wl-copy`) by default, with commented alternatives for X11 and WSL.
- LSP servers configured: `rust_analyzer` (with clippy), `pyright`, `ruff`.
- Neovim auto-strips trailing whitespace on save.
