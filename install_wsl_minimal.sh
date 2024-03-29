# Remove old VIM files
rm -rf ~/.vim
rm ~/.vimrc

# Copy new VIM files
cp -r vim ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp _vimrc_wsl_minimal ~/.vimrc

# Install plugins
vim +PluginInstall +qall
