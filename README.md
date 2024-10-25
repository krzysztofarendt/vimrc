# My NeoVim environment

I use mostly NeoVim instead of Vim [nowadays](nowadays), so `init.lua` is more up-to-date than `.vimrc`.

## Installation instructions

- Install the newest NeoVim (>=0.10): https://neovim.io/
- Install `cmake`: `sudo apt install cmake`
- Install `ripgrep`: `sudo apt install ripgrep`
- Install `fd`: `sudo apt install fd-find`
- Install `nvm`: `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash`
- Update Node.js: `nvm install 20`
- Install [pyright](https://microsoft.github.io/pyright/#/installation)
- Install [clangd](https://clangd.llvm.org/)
- Install `FiraCode Nerd Font` from [here](https://www.nerdfonts.com/font-downloads)
- Copy `init.lua` to `~/.config/nvim/init.lua`
- Open `nvim`
- Wait until all plugins are installed
- Run in NeoVim:
    - `:TSInstall lua`
    - `:TSInstall python`
    - `:TSInstall c`
    - `:TSInstall markdown`
- (Optional) Install [lua-language-server](https://luals.github.io/wiki/build/) and add it to $PATH
- (Optional) Uncomment `lspconfig.lua_ls.setup{capabilities = capabilities}`
- (Optional) Add to your `.bashrc`: `export ANTHROPIC_API_KEY=your-api-key`

## Custom key bindings

| Keymap       | Type    | Function                                                   |
|--------------|---------|------------------------------------------------------------|
| `<F9>`       | General | Toggle file explorer (nvim-tree)                           |
| `<F8>`       | General | Toggle file explorer (Oil)                                 |
| `<F7>`       | General | Toggle terminal                                            |
| `<F6>...`    | General | Toggle new terminal with ID ... (use a number here)        |
| `<F5>`       | General | Toggle line numbers                                        |
| `<F4>`       | General | Toggle transparent background                              |
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
| `zM`         | General | Fold all                                                   |
| `zc`         | General | Close fold under the cursor                                |
| `zo`         | General | Open fold under the cursor                                 |
| `za`         | General | Toggle fold under the cursor                               |
| `\tm`        | General | Toggle table mode (vim-table-mode plugin)                  |


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
