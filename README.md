# My VIM environment

## Installation instructions

The installation scripts replace the vim directory (`~/.vim` on Linux, `%USERPROFILE%\vimfiles` on Windows) and vimrc file (`~/.vimrc` on Linux, `%USERPROFILE%\_vimrc` on Windows) with the versions from this repository. Subsequently, it downloads and installs Vundle and all plugins listed in vimrc.

Prerequisites (these commands must be in the PATH):
- vim,
- git,
- curl.

### Linux

```
install_linux.sh
```

### WSL (running in Windows Terminal)

Almost identical as the Linux version. The differences are the cursor shape fix for Windows Terminal and a clipboard shared between WSL and Windows:

```
install_wsl.sh
```

### Windows

Works equally fine in GVim and in Windows Terminal:

```
install_windows.bat
```
