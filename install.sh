#!/bin/bash
ppas=`cat << EOS
ppa:ubuntu-desktop/ubuntu-make
ppa:nilarimogard/webupd8
ppa:neovim-ppa/unstable
ppa:dawidd0811/neofetch
ppa:japaneseteam/ppa
ppa:budgie-remix/ppa
ppa:peek-developers/stable
ppa:papirus/papirus
ppa:kazam-team/unstable-series
ppa:hluk/copyq
ppa:webupd8team/brackets
EOS`
apps=`cat << EOS
papirus-icon-theme
gparted
kazam
brackets
copyq
peek
neofetch
budgie-core
budgie-desktop
budgie-indicator-applet
budgie-lightdm-theme
budgie-remix-lightdm-theme
budgie-screenshot-applet
budgie-wallpapers
budgie-wallpapers-xenial
budgie-welcome
ubuntu-make
gufw
nemo-audio-tab
nemo-compare
nemo-image-converter
nemo-pastebin
nemo-terminal
asunder
audacity
vlc
lame
shutter
nemo
software-properties-common
python-software-properties
gnome-sushi
openshot
gimp
inkscape
ubuntu-restricted-extras
git
ibus-mozc
xbacklight
vim
unity-tweak-tool
zsh
tmux
leafpad
nautilus-emblems
python-dev
python-pip
python3-dev
python3-pip
xsel
build-essential
libssl-dev
neovim
albert
dconf-editor
kdenlive
EOS`
downloadurls=`cat << EOS
https://www.google.co.jp/chrome/browser/desktop/index.html
http://qiita.com/ygkn/items/94171310be7f0115c764
https://slack.com/downloads/linux
EOS`


exeRoot(){
# Install
  apt update
  apt upgrade

  for ppa in $ppas; do
    add-apt-repository $ppa
  done

  apt update

  for app in $apps; do
    apt install $app
  done


# Node.js
  apt install nodejs npm
  npm cache clean
  npm install n -g
  n stable
  ln -sf /usr/local/bin/node /usr/bin/node
  node -v
  apt purge -y nodejs npm

  ./zsh-install.sh
}

sudo exeRoot

#Ruby rbenv
cd
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# NeoVim
update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
update-alternatives --config vi
update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
update-alternatives --config vim
update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
update-alternatives --config editor

pip3 install neovim

# commands
LANG=C xdg-user-dirs-gtk-update
/usr/share/doc/libdvdread4/install-css.sh

# dotfiles
git clone git@github.com:ygkn/dotfiles.git
cd dotfiles
ln -s $(pwd)/.gitconfig ~
ln -s $(pwd)/.gitignore_global ~
ln -s $(pwd)/.tmux.conf ~
ln -s $(pwd)/.zshrc ~
ln -s $(pwd)/.vim ~
ln -s $(pwd)/nvim ~/.config/nvim

for url in $downloadurls; do
  xdg-open $urls
done

# Theme
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' >> /etc/apt/sources.list.d/arc-theme.list"

sudo apt-get update && sudo apt-get install arc-theme
wget http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_16.04/Release.key
sudo apt-key add - < Release.key
