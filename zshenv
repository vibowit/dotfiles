# -*- mode: Shell-script; -*-
# vibowit's .zshenv file
# Time-stamp: <2012-07-20 14:21:21 by bwitkowski>

# First things first...
export EDITOR='emacsclient -c'
export VISUAL='emacsclient -c'

typeset -U path
path=(~/bin $path)

# check if user vibo exists and add his fns to fpath
# then autoload all his functions
(id vibo > /dev/null 2>&1) && (
    [[ $fpath = *vibo* ]] || fpath=(~vibo/bin/fns $fpath)
    autoload -U ${fpath[1]}/*(:t)
)
