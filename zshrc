autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

zmodload -i zsh/complist

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
DISABLE_AUTO_TITLE="false"

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell

setopt auto_cd # cd by typing directory name if it's not a command

setopt correct_all # autocorrect commands

setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# bindkey '^[[3~' delete-char
# bindkey '^[3;5~' delete-char

source <(antibody init)
antibody bundle zdharma/fast-syntax-highlighting
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-history-substring-search
antibody bundle zsh-users/zsh-completions

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# SPACESHIP_PROMPT_ORDER=(
#   user          # Username section
#   dir           # Current directory section
#   host          # Hostname section
#   git           # Git section (git_branch + git_status)
#   hg            # Mercurial section (hg_branch  + hg_status)
#   exec_time     # Execution time
#   line_sep      # Line break
#   vi_mode       # Vi-mode indicator
#   jobs          # Background jobs indicator
#   exit_code     # Exit code section
#   char          # Prompt character
# )
# SPACESHIP_PROMPT_ADD_NEWLINE=false
# SPACESHIP_CHAR_SYMBOL="❯"
# SPACESHIP_CHAR_SUFFIX=" "

# antibody bundle denysdovhan/spaceship-prompt

fpath+=$HOME/.zsh/zsh-clean

autoload -U promptinit; promptinit
prompt wordy # for Xterm

# add node_modules path
path+=($HOME/node_modules/.bin)

# functions
function ssh() { /usr/bin/ssh -t $@ "tmux attach || tmux new"; }

# aliases

alias ls="ls --color"
alias ll="ls -la --color"
alias install="sudo apt install"
alias remove="sudo apt remove --purge"
alias search="sudo apt search"
alias upgrade="sudo apt update; sudo apt upgrade -y"
alias -s md="code"
alias -s txt="code"
alias vim="nvim"
alias v="nvim"
alias api="cd ~/go/src/github.com/vibowit/pointers"

# If i use flatpak version of neovim
# There is one problem with flatpak version. It does not integrate with tmux well.

#alias nvim="/var/lib/flatpak/exports/bin/io.neovim.nvim"
#alias vim="/var/lib/flatpak/exports/bin/io.neovim.nvim"

export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="${PATH}:${HOME}/.local/bin/:/usr/local/go/bin:$GOPATH/bin"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
