rm -rf ~/.vim
rm ~/.vimrc
cp -r vim ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp _vimrc_linux ~/.vimrc
vim +PluginInstall +qall
# Initialize jedi-vim
cd ~/.vim/bundle/jedi-vim
git submodule update --init --recursive
cd ~
