# -*- mode: Shell-script; -*-

# First things first...
export EDITOR='emacsclient -c'
export VISUAL='emacsclient -c'

typeset -U path
# path=(~/bin ~/progs/bin $path)

path=(~/bin $path)

(id vibo > /dev/null 2>&1) && (
    [[ $fpath = *vibo* ]] || fpath=(~vibo/bin/fns $fpath)
    autoload -U ${fpath[1]}/*(:t)
)
