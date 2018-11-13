#!/usr/bin/env fish
set -x XDG_CONFIG_HOME ~/.config
umask 0022
set PATH ~/.cargo/bin $PATH
set PATH ~/bin $PATH
alias psgrep 'ps auxww|grep -v grep|egrep'
alias , clear
alias g git
alias p pijul

alias vim=nvim
alias v=nvim

alias c cargo
alias cb 'cargo build'
alias cr 'cargo run'
alias ct 'cargo test'
alias crontab 'crontab -i'

set -Ux LLVM_SYS_40_PREFIX $HOME/etc/llvm-4.0.0
set -Ux LLVM_SYS_50_PREFIX $HOME/etc/llvm-5.0.0.src/build/
set -Ux GOPATH $HOME/cnf/Go
set PATH $GOPATH/bin $PATH

