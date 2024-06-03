# My NeoVim environment

Nowadays, I use mostly NeoVim instead of Vim, so `init.lua` is more up-to-date than `.vimrc`.

## Installation instructions

1. Install the newest NeoVim (>=0.10): https://neovim.io/
2. Install `ripgrep`: `sudo apt install ripgrep`
3. Install `fd`: `sudo apt install fd-find`
4. Install (pyright)[https://microsoft.github.io/pyright/#/installation]
5. Install (lua-language-server)[https://luals.github.io/wiki/build/] and add it to $PATH
6. Install `FiraCode Nerd Font` from (here)[https://www.nerdfonts.com/font-downloads]
7. Copy `init.lua` to `~/.config/nvim/init.lua`
8. Open `nvim`
9. Wait until all plugins are installed
10. Run in NeoVim:
    - `:TSInstall lua`
    - `:TSInstall python`
    - `:TSInstall c`
    - `:TSInstall markdown`
11. (Optional) Make account on codeium: https://codeium.com/
12. (Optional) Uncomment the codeium plugin in the Lazy setup section
13. (Optional) Run in NeoVim: `:Codeium Auth`

## Neovim keybindings

| Keymap       | Type    | Function                                                   |
|--------------|---------|------------------------------------------------------------|
| `<F9>`       | General | Toggle file explorer (nvim-tree)                                 |
| `<F8>`       | General | Toggle file explorer (Oil)                                 |
| `<F7>`       | General | Toggle terminal                                            |
| `<F6>...`    | General | Toggle new terminal with ID ... (use a number here)        |
| `<F5>`       | General | Toggle line numbers                                        |
| `\hh`        | General | Hop word                                                   |
| `\ff`        | General | Find file                                                  |
| `\ff`        | General | Search open buffers                                        |
| `\fs`        | General | Use over a string, it will find all files with this string |
| `\fg`        | General | Grep through files (try with <c-f> inside search window)   |
| `\p`         | General | Show current file absolute path                            |
| `@r`         | General | Macro for visual replacement from buffer                   |
| `\dt`        | General | Insert current date and time                               |
| `<space>e`   | Python  | Show diagnostic window (Python errors from pyright)        |
| `gd`         | Python  | Go to definition                                           |
| `gD`         | Python  | Go to declaration                                          |
| `<C-k>`      | Python  | Signature help                                             |
| `<space>rn`  | Python  | Rename                                                     |
| `K`          | Python  | Hover help                                                 |
| `<c-x><c-o>` | Python  | Trigger autocomplete via omnifunc                          |

# My VIM environment

I switched from Vim to NeoVim, but still keep a copy my `.vimrc`. Last update: 14.11.2023.

## Installation instructions

The installation scripts replace the vim directory (`~/.vim` on Linux, `%USERPROFILE%\vimfiles` on Windows) and vimrc file (`~/.vimrc` on Linux, `%USERPROFILE%\_vimrc` on Windows) with the versions from this repository. Subsequently, it downloads and installs Vundle and all plugins listed in vimrc.

Prerequisites (these commands must be in the PATH):
- `vim`
- `git`
- `curl`

### Linux

If you want to use `YouCompleteMe`, just run:
```
./install_linux.sh
```

If you do not wish to use `YouCompleteMe`, you need to comment lines 17-23 in `install_linux.sh` and line 28 in `_vimrc_linux`.

### WSL (running in Windows Terminal)

Almost identical to the Linux version. The differences are the cursor shape fix for Windows Terminal and a clipboard shared between WSL and Windows:

If you want to use `YouCompleteMe`, just run:
```
./install_wsl.sh
```

If you do not wish to use `YouCompleteMe`, you need to comment lines 17-23 in `install_wsl.sh` and line 28 in `_vimrc_wsl`.

### Windows

Works equally fine in GVim and in Windows Terminal.
Uses `jedi-vim` instead of `YouCompleteMe`.
```
install_windows.bat
```

### Docker

See `Makefile` and `Dockerfile`.

# Default editor for git (Linux / WSL)
```
git config --global core.editor "vim"
git config --global merge.tool vimdiff
git config --global merge.conflictstyle diff3
git config --global mergetool.prompt false
```

# tmux (Linux / WSL)
```
cp _tmux.conf ~/.tmux.conf
```
