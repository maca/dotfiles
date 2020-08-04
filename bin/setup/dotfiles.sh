#!/usr/bin/sh
#
# Usage
# bash <(curl -s https://raw.githubusercontent.com/maca/dotfiles/master/bin/setup/dotfiles.sh)

cd $HOME

git clone git@github.com:maca/dotfiles.git

cd /tmp

mkdir -p ~/.config
mkdir -p ~/.config/pulseaudio-ctl/

ln -fs $HOME/dotfiles/systemd ~/.config/systemd
ln -fs $HOME/dotfiles/redshift.conf ~/.config/redshift.conf

ln -fs /scratch ~/Downloads
ln -fs $HOME/dotfiles/zshrc ~/.zshrc
ln -fs $HOME/dotfiles/zprofile ~/.zprofile
ln -fs $HOME/dotfiles/vimrc ~/.vimrc
ln -fs $HOME/dotfiles/vim ~/.vim
ln -fs $HOME/dotfiles/emacs.el ~/.emacs
ln -fs $HOME/dotfiles/conky ~/.conky
ln -fs $HOME/dotfiles/gitconfig ~/.gitconfig
ln -fs $HOME/dotfiles/tmux.conf ~/.tmux.conf
ln -fs $HOME/dotfiles/xinitrc ~/.xinitrc
ln -fs $HOME/dotfiles/Xresources ~/.Xresources
ln -fs $HOME/dotfiles/urxvt/ ~/.urxvt
ln -fs $HOME/dotfiles/themes ~/.themes
ln -fs $HOME/dotfiles/gitignore ~/.gitignore
ln -fs $HOME/dotfiles/bin ~/bin
ln -fs $HOME/dotfiles/dynamic-colors ~/.dynamic-colors
ln -fs $HOME/dotfiles/pam_environment ~/.pam_environment
ln -fs $HOME/dotfiles/pulseaudio-ctl.config ~/.config/pulseaudio-ctl/config


source $HOME/.zshrc

cd $HOME

git clone git@gitlab.com:aelita/pass.git $HOME/.password-store
mkdir -p .password-store/.git/hooks
ln -fs $HOME/dotfiles/password-store/hooks ~/.password-store/.git/hooks/


mkdir .ssh
echo "AddKeysToAgent yes" >> ~/.ssh/config
