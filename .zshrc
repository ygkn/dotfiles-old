# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
#zstyle :compinstall filename '/home/ygkn/.zshrc'


#set path to a directory where there is ithief
PATH=$PATH:/opt/local/bin:./node_modules/.bin

# -------------------------------------
# environment variables
# -------------------------------------

# SSHで接続した先で日本語が使えるようにする
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# エディタ
export EDITOR=/usr/bin/vim

# ページャ
# export PAGER=/usr/local/bin/vimpager
# export MANPAGER=/usr/local/bin/vimpager

# -------------------------------------
# zsh options
# -------------------------------------


## 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt correct

# ビープを鳴らさない
setopt nobeep

## 色を使う
setopt prompt_subst

## ^Dでログアウトしない。
setopt ignoreeof

## バックグラウンドジョブが終了したらすぐに知らせる。
setopt no_tify

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

# 補完
## タブによるファイルの順番切り替えをしない
unsetopt auto_menu

# cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
setopt auto_pushd

# ディレクトリ名を入力するだけでcdできるようにする
setopt auto_cd

#先方予測機能
#autoload predict-on
#predict-on

# -------------------------------------
# path
# -------------------------------------

# 重複する要素を自動的に削除
typeset -U path cdpath fpath manpath

path=(
    $HOME/bin(N-/)
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    $path
)

# -------------------------------------
# prompt
# -------------------------------------

autoload -U promptinit; promptinit
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz is-at-least
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
autoload -Uz add-zsh-hook
add-zsh-hook precmd vcs_info
# end VCS

OK=":) "
NG=":( "

PROMPT=""
PROMPT+="%(?.%F{green}$OK%f.%F{red}$NG%f) "
PROMPT+="
%n@%m:%~"
PROMPT+=' '
PROMPT+="$vcs_info_msg_0_"
PROMPT+="
 %% "

RPROMPT="[%*]"

# -------------------------------------
# alias
# -------------------------------------

# -n 行数表示, -I バイナリファイル無視, svn関係のファイルを無視
alias grep="grep --color -n -I --exclude='*.svn-*' --exclude='entries' --exclude='*/cache/*'"

# ls
alias ls="ls -G"
alias l="ls -la"
alias la="ls -la"
alias l1="ls -1"

#ls colors (http://news.mynavi.jp/column/zsh/009/)
export LSCOLORS=xxfxcxdxbxegedabagacad
alias ls="ls -G"

#add tree command line to zsh
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"

# -------------------------------------
# key bind
# -------------------------------------

bindkey -v

function cdup() {
   echo
   cd ..
   zle reset-prompt
}
zle -N cdup
bindkey '^K' cdup

bindkey "^R" history-incremental-search-backward

# -------------------------------------
# others
# -------------------------------------

# cdしたあとで、自動的に ls する
function chpwd() { ls -1 }

 if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
alias pbcopy='xsel --clipboard --input'

function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export NVM_DIR="/home/ygkn/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm


alias g='git add -A ; git commit -v'
alias gp='git add -A ; git commit -v ; git push'

export TERM="screen-256color"

alias copy='xsel --clipboard --input'
alias bs='browser-sync start --server --files "**/*"'
mkcd(){mkdir -p "$@" && eval cd "\"\$$#\"";}

alias gls='git branch'
alias gcd='git checkout'
alias gmk='git branch'
alias grm='git branch -d'
alias gmv='git branch -m'
alias gmg='git merge'
alias v='vim'
alias y='yarn'

fpath=(~/.zsh/completion $fpath)

autoload -U compinit
compinit -u
source ~/.git-flow-completion.zsh

alias :e='vim'
alias ys='yarn start'
