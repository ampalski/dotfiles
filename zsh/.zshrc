# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

 # start typing + [Up-Arrow] - fuzzy find history forward
# if [[ "${terminfo[kcuu1]}" != "" ]]; then
#     autoload -U up-line-or-beginning-search
#     zle -N up-line-or-beginning-search
#     bindkey "^[[A" up-line-or-beginning-search
# fi
# # start typing + [Down-Arrow] - fuzzy find history backward
# if [[ "${terminfo[kcud1]}" != "" ]]; then
#     autoload -U down-line-or-beginning-search
#     zle -N down-line-or-beginning-search
#     bindkey "^[[B" down-line-or-beginning-search
# fi
# Load the search functions
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Bind Up Arrow
if [[ -n "${terminfo[kcuu1]}" ]]; then
    bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# Fallback for Up Arrow if terminfo fails
bindkey '^[[A' up-line-or-beginning-search

# Bind Down Arrow
if [[ -n "${terminfo[kcud1]}" ]]; then
    bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi
# Fallback for Down Arrow if terminfo fails
bindkey '^[[B' down-line-or-beginning-search
# Trying to get plotting in Julia to work
export DISPLAY=:1

# ALIASES
alias la="ls -al"
alias 2b="~/.local/scripts/secondbrain.sh"
alias fd="fd"
alias jo="julia --threads 12"
# alias zen="~/Applications/Zen/zen-specific.AppImage"
# alias obsidian="~/Applications/Obsidian/Obsidian-1.7.7.AppImage"
alias tm="~/dotfiles/scripts/ssh_agent_tmux.sh"
alias tms="~/dotfiles/scripts/tmux-sessionizer"
alias rebuild="sudo nix flake update; sudo nixos-rebuild switch --impure --flake ~/dotfiles/nixos"
alias upgrade="sudo nixos-rebuild switch --upgrade"

path=('/home/andrew/.julia/bin' $path)
export PATH

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/andrew/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<

eval "$(zoxide init zsh)"
