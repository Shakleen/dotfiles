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

# -------------------------------------------------------------
# Git aliases
# -------------------------------------------------------------
alias gs="git status --short"
alias ga="git add"
alias gap="git add --patch"
alias gd="git diff --output-indicator-new=' ' --output-indicator-old=' '"
alias gc="git commit"
alias gp="git push"
alias gu="git pull"
alias gl="git log --all --graph --pretty\
    format: '%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'"
alias gb="git branch"
alias gi="git init"
alias gcl="git clone"

# Other aliases
alias gemini="npx https://github.com/google-gemini/gemini-cli"

# -------------------------------------------------------------
# fzf Configurations
# -------------------------------------------------------------
eval "$(fzf --bash)"

# For git integration with fzf
source ~/fzf-git.sh 

# fzf previews with bat and eza
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}
# -------------------------------------------------------------
# -- Use fd instead of fzf --
# -------------------------------------------------------------
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# -------------------------------------------------------------
# ----- Bat (better cat) -----
# -------------------------------------------------------------
export BAT_THEME=TwoDark

# -------------------------------------------------------------
# ---- Eza (better ls) -----
# -------------------------------------------------------------
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# -------------------------------------------------------------
# ---- zoxide (better cd) -----
# -------------------------------------------------------------
eval "$(zoxide init bash)"
alias cd="z"

fastfetch
