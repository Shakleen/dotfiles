#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

##-----------------------------------------------------
## synth-shell-prompt.sh
if [ -f /home/shakleen/.config/synth-shell/synth-shell-prompt.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/shakleen/.config/synth-shell/synth-shell-prompt.sh
fi

# Git aliases
alias gs="git status --short"
alias ga="git add"
alias gd="git diff --output-indicator-new=' ' --output-indicator-old=' '"
alias gc="git commit"
alias gp="git push"
alias gu="git pull"
alias gl="git log"
alias gb="git branch"
alias gi="git init"
alias gcl="git clone"
