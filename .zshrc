export PATH="/opt/homebrew/opt/llvm/bin:/opt/homebrew/opt/gcc/bin:/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export GREP_OPTIONS="--color=always"
alias gcc="gcc-14"
alias g++="g++-14"
alias grep="/opt/homebrew/opt/grep/bin/ggrep"

PS1="%F{blue}%~%f %F{red}$%f "
set -o vi
alias vim="nvim"
alias vi="nvim"
