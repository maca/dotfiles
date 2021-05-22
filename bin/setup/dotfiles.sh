#!/usr/bin/sh
#

cd $HOME

cd /tmp

mkdir -p ~/.config

ln -fs $HOME/dotfiles/systemd ~/.config/systemd

ln -fs /scratch ~/Downloads
ln -fs $HOME/dotfiles/zshrc ~/.zshrc
ln -fs $HOME/dotfiles/zprofile ~/.zprofile
ln -fs $HOME/dotfiles/vimrc ~/.vimrc
ln -fs $HOME/dotfiles/vim ~/.vim
ln -fs $HOME/dotfiles/conky ~/.conky
ln -fs $HOME/dotfiles/gitconfig ~/.gitconfig
ln -fs $HOME/dotfiles/tmux.conf ~/.tmux.conf
ln -fs $HOME/dotfiles/themes ~/.themes
ln -fs $HOME/dotfiles/gitignore ~/.gitignore
ln -fs $HOME/dotfiles/bin ~/bin
ln -fs $HOME/dotfiles/pam_environment ~/.pam_environment


cd $HOME

git clone git@gitlab.com:aelita/pass.git $HOME/.password-store
mkdir -p .password-store/.git/hooks
ln -fs $HOME/dotfiles/password-store/hooks ~/.password-store/.git/


echo "AddKeysToAgent yes" >> ~/.ssh/config
