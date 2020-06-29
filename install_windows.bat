rmdir %USERPROFILE%\vimfiles /s /q
del %USERPROFILE%\_vimrc
xcopy vim %USERPROFILE%\vimfiles /s /e
git clone https://github.com/VundleVim/Vundle.vim.git %USERPROFILE%/vimfiles/bundle/Vundle.vim
xcopy _vimrc_windows %USERPROFILE%\_vimrc
vim +PluginInstall +qall
