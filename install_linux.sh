
rm -rf ~/.vim
rm ~/.vimrc
cp -r vim ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp _vimrc_linux ~/.vimrc
vim +PluginInstall +qall
