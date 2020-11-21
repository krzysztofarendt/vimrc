# Remove old VIM files
rm -rf ~/.vim
rm ~/.vimrc

# Copy new VIM files
cp -r vim ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp _vimrc_linux ~/.vimrc

# Install plugins
vim +PluginInstall +qall

# Initialize jedi-vim - USING YCM NOW
# cd ~/.vim/bundle/jedi-vim
# git submodule update --init --recursive

# Compile YCM
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --all

cd ~
