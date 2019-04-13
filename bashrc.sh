#!/bin/bash

[ -f ~/.bashrc ] && . ~/.bashrc

# go to mounted directory
cd /userdata

# use bash-completion
. /etc/bash_completion

service openvswitch-switch start

# use bash-completion
. /etc/bash_completion

alias ovs-ofctl="ovs-ofctl -OOpenFlow13"
eval $(opam env)
eval `opam config env`
