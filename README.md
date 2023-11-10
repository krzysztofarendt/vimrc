# My VIM environment

## Installation instructions

The installation scripts replace the vim directory (`~/.vim` on Linux, `%USERPROFILE%\vimfiles` on Windows) and vimrc file (`~/.vimrc` on Linux, `%USERPROFILE%\_vimrc` on Windows) with the versions from this repository. Subsequently, it downloads and installs Vundle and all plugins listed in vimrc.

Prerequisites (these commands must be in the PATH):
- vim,
- git,
- curl.

### Linux

If you want to use YouCompleteMe, just run:
```
./install_linux.sh
```

If you do not wish to use YouCompleteMe, you need to comment lines 17-23 in `install_linux.sh` and line 28 in `_vimrc_linux`.

### WSL (running in Windows Terminal)

Almost identical as the Linux version. The differences are the cursor shape fix for Windows Terminal and a clipboard shared between WSL and Windows:

If you want to use YouCompleteMe, just run:
```
./install_wsl.sh
```

If you do not wish to use YouCompleteMe, you need to comment lines 17-23 in `install_wsl.sh` and line 28 in `_vimrc_wsl`.

### Windows

Works equally fine in GVim and in Windows Terminal:

```
install_windows.bat
```

## Set up git
```
git config --global core.editor "vim"
git config --global merge.tool vimdiff
git config --global merge.conflictstyle diff3
git config --global mergetool.prompt false
```
