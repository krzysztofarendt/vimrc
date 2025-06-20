Rem Remove previous VIM files
rmdir %USERPROFILE%\vimfiles /s /q
del %USERPROFILE%\_vimrc

Rem Copy new VIM files
xcopy vim %USERPROFILE%\vimfiles /s /e
git clone https://github.com/VundleVim/Vundle.vim.git %USERPROFILE%/vimfiles/bundle/Vundle.vim
xcopy _vimrc_windows %USERPROFILE%\_vimrc

Rem Install plugins
vim +PluginInstall +qall

Rem Initialize jedi-vim
C:
cd %USERPROFILE%\vimfiles\bundle\jedi-vim
git submodule update --init --recursive

Rem YouCompleteMe compilation (make sure you have all dependencies and python-capable Vim)
Rem Comment these lines if you want to switch off YCM
Rem C:
Rem cd %USERPROFILE%\vimfiles\bundle\YouCompleteMe
Rem python install.py --all
