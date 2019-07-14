#!/usr/bin/sh
#
# Usage
# bash <(curl -s https://raw.githubusercontent.com/maca/dotfiles/master/bin/setup/dotfiles.sh)

cd $HOME

git clone git@github.com:maca/dotfiles.git

cd /tmp

mkdir -p ~/.config

ln -fs $HOME/dotfiles/systemd ~/.config/systemd
ln -fs $HOME/dotfiles/redshift.conf ~/.config/redshift.conf

ln -fs /scratch ~/Downloads
ln -fs $HOME/dotfiles/zshrc ~/.zshrc
ln -fs $HOME/dotfiles/zprofile ~/.zprofile
ln -fs $HOME/dotfiles/vimrc ~/.vimrc
ln -fs $HOME/dotfiles/vim ~/.vim
ln -fs $HOME/dotfiles/conky ~/.conky
ln -fs $HOME/dotfiles/gitconfig ~/.gitconfig
ln -fs $HOME/dotfiles/tmux.conf ~/.tmux.conf
ln -fs $HOME/dotfiles/xinitrc ~/.xinitrc
ln -fs $HOME/dotfiles/Xresources ~/.Xresources
ln -fs $HOME/dotfiles/themes ~/.themes
ln -fs $HOME/dotfiles/ctags.d ~/.ctags.d
ln -fs $HOME/dotfiles/gitignore ~/.gitignore
ln -fs $HOME/dotfiles/bin ~/bin
ln -fs $HOME/dotfiles/dynamic-colors ~/.dynamic-colors
ln -fs $HOME/dotfiles/pam_environment ~/.pam_environment

$HOME/dotfiles/bin/aur -si chruby oh-my-zsh-git par ruby-install-git \
  vim-plug universal-ctags-git heroku-client

source $HOME/.zshrc

cd $HOME

git clone git@gitlab.com:aelita/pass.git $HOME/.password-store
mkdir -p .password-store/.git/hooks
ln -fs $HOME/dotfiles/password-store/hooks ~/.password-store/.git/hooks/

vim +PlugInstall +qall

systemctl --user enable ssh-agent
systemctl --user start ssh-agent
