# Remove old VIM files
rm -rf ~/.vim
rm ~/.vimrc

# Copy new VIM files
cp -r vim ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp _vimrc_wsl ~/.vimrc

# Install plugins
vim +PluginInstall +qall

# Initialize YouCompleteMe
# https://github.com/ycm-core/YouCompleteMe#linux-64-bit
# Uncomment below lines to install YCM
# ===========================================================
# sudo apt install build-essential cmake vim-nox python3-dev
# sudo mkdir -p /etc/apt/keyrings
# curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
# sudo echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_current.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
# sudo apt install mono-complete golang nodejs openjdk-17-jdk openjdk-17-jre npm
# cd ~/.vim/bundle/YouCompleteMe
# python3 install.py --all

# Initialize jedi-vim
# Uncomment below lines to install jedi-vim
# ===========================================================
# cd ~/.vim/bundle/jedi-vim
# git submodule update --init --recursive

cd ~
