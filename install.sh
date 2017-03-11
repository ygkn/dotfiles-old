#!/bin/bash
ppas=$(cat) << EOS
ppa:nilarimogard/webupd8
ppa:neovim-ppa/unstable
ppa:japaneseteam/ppa
EOS
apps=$(cat) << EOS
gufw
nemo-audio-tab
nemo-compare
nemo-image-converter
nemo-pastebin
nemo-terminal
asunder
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
EOS
downloadurls=$(cat) << EOS
http://hluk.github.io/CopyQ/
https://www.google.co.jp/chrome/browser/desktop/index.html
http://brackets.io
http://qiita.com/ygkn/items/94171310be7f0115c764
EOS


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
ln -s $(pwd)/.* ~
ln -s $(pwd)/nvim ~/.config/nvim

for url in $downloadurls; do
  xdg-open $urls
done

