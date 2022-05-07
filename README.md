# Installation instructions

The installation scripts replace the vim directory (`~/.vim` on Linux, `%USERPROFILE%\vimfiles` on Windows) and vimrc file (`~/.vimrc` on Linux, `%USERPROFILE%\_vimrc` on Windows) with the versions from this repository. Subsequently, it downloads and installs Vundle and all plugins listed in vimrc.

Prerequisites (these commands must be in the PATH):
- vim,
- git,
- curl.

## Linux

```
install_linux.sh
```

## WSL (running in Windows Terminal)

Almost identical as the Linux version. The only difference is the cursor shape fix for Windows Terminal:

```
install_wsl.sh
```

## Windows

Works fine with GVim, but the colors might be broken in Windows Terminal:

```
install_windows.bat
```
