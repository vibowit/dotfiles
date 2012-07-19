# -*- mode: Shell-script; -*-

# Nie mogę zapamiętać nazw programów to sobie wypiszę
# wgetpaste - wrzucanie do pastebin
# scrot - zrzut ekranu do pliku png
# feh - przeglądarka do zdjęć
# wicd-client - ustawienia połączeń wifi
# ompload - upload zdjęć itp. (coś ala imageshack)
# Xephyr - do testowania configa awesome 
# $ Xephyr :1 -ac -br -noreset -screen 1152x720 &
# $ DISPLAY=:1.0 awesome -c ~/.config/awesome/rc.lua.new

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="candy"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ruby)
source $ZSH/oh-my-zsh.sh

# customize compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# Customize to your needs...
HISTFILE="${HOME}/.zsh_history"
HISTSIZE='10000'
SAVEHIST="${HISTSIZE}"

# automatyczne poprawianie polecen
setopt correctall

# extended globbing, awesome!
setopt extended_glob

# zmv -  a command for renaming files by means of shell patterns.
autoload -U zmv

# zargs, as an alternative to find -exec and xargs.
autoload -U zargs

# nice zsh functions
autoload -U is-at-least

# Turn on command substitution in the prompt (and parameter expansion and arithmetic expansion).
setopt promptsubst

# Ignore duplicate in history.
setopt hist_ignore_all_dups
setopt hist_ignore_dups

# Prevent record in history entry if preceding them with at least one space
setopt hist_ignore_space

# Nobody need flow control anymore. Troublesome feature.
#stty -ixon
setopt noflowcontrol

# Other options
setopt autocd

unsetopt beep

# Pushhd
setopt auto_pushd
setopt pushd_ignore_dups

# Bindkeys
setopt emacs
# do naprawy home i end w zsh i urxvt (mam problem w cygwin)
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line

# Aliases
alias zshconfig="emacsclient -c ~/.zshrc"
alias ohmyzsh="emacsclient -c ~/.oh-my-zsh"

alias sasprd="ssh bwitkows@sas_srv"
alias sastst="ssh bwitkows@sastst"
alias bull="ssh vibowit@bull"

alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias ls='ls --color=auto --human-readable --group-directories-first --classify'

# alias cp='nocorrect cp'
# alias mv='nocorrect mv'
# alias mkdir='nocorrect mkdir'

alias vi="emacsclient -c"
alias e="emacsclient -c"
alias ed="emacsclient -t"
alias E="SUDO_EDITOR=\"emacsclient -c -a emacs\" sudoedit"
alias T="SUDO_EDITOR=\"emacsclient -t -a emacs\" sudoedit"

alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g GI='| grep -i'
alias -g L="| less"
# alias -g M="| most"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"

alias f='find . -name'
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias fogrep='fc-list | grep -i' # bylo {fc-list; xlsfonts}, ale w cygwin nie dziala
alias h='history'
alias hgrep="fc -El 0 | grep"
alias help='man'
alias j='jobs'
# alias dn='disown'
# alias mm='mplayer -nosound'
# alias m='mplayer'
alias n='emacsclient -c $HOME/.notes'
alias p='ps -f'
alias s='ssh'
alias sortnr='sort -n -r'

#list whats inside packed file
alias -s zip="unzip -l"
alias -s rar="unrar l"
alias -s tar="tar tf"
alias -s tar.gz="echo "
alias -s ace="unace l"
alias -s txt="cat"

# Keys
bindkey "^R" history-incremental-pattern-search-backward 
bindkey "^S" history-incremental-pattern-search-forward

# if XWin is not running start it
# ISX=`ps -ef | grep -i XWin | wc -l`
# if [[ $ISX -eq "0" ]]; then
#     startx
#     echo "Start XWin..."
# fi 

# # set $DISPLAY
# if [ -z "$DISPLAY" ] ; then
#     export DISPLAY="`hostname`:0.0"
#     echo Display:$DISPLAY
# fi

# Some SAS tools
# someday this part will have separate file
sas_prdEdit() {
    /usr/bin/emacsclient -c "/bwitkows@sas_srv:$1"
}

sas_findLog() {
  [[ $#@ -eq 2 ]] || { 
      echo "$0 : Give exactly two arguments:"
      echo "    NAME - part of flow name"
      echo "    TIME - numer of days to look back"
      return 1 
  }
  command ssh bwitkows@sas_srv "find / -name \"*$1*.log\" -atime $2 2>/dev/null"
}

