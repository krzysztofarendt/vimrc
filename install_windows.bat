cp -r vim %USERPROFILE%\vimfiles
git clone https://github.com/VundleVim/Vundle.vim.git %USERPROFILE%/vimfiles/bundle/Vundle.vim
cp _vimrc_windows %USERPROFILE%\_vimrc
vim +PluginInstall +qall
