#!/bin/bash

[ -f ~/.bashrc ] && . ~/.bashrc

# go to mounted directory
cd /userdata

# use bash-completion
. /etc/bash_completion

eval $(opam env)
eval `opam config env`
