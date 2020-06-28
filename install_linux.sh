cp -r vim ~/.vim
git clone https://github.com/preservim/nerdtree.git
~/.vim/pack/vendor/start/nerdtree
vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q
cp _vimrc_linux ~/.vimrc
