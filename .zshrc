# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_DISABLE_COMPFIX=true

# use the application provided by Homebrew instead of the system default
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

# Default editor
export EDITOR=vim
# export EDITOR=nvim

# Add macvim to path
# ref: https://michaelsoolee.com/launch-macvim-from-terminal/
alias mvim="/Applications/MacVim.app/Contents/bin/mvim"

# add to dotfiles repository
alias dgit="git --git-dir ~/Desktop/dotfiles/.git/ --work-tree=$HOME"

############ Setting ZSH ############
export ZSH="/Users/andy/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

source $ZSH/oh-my-zsh.sh

# User configuration

# Emacs mode
bindkey -e

# Vim mode
# bindkey -v
#
# Use original vim mode in terminal command line
# set -o vi

# Grep color
alias ggrep='ggrep --color=auto'
export GREP_COLORS='ms=01;31'

plugins=(git)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# For zsh highlight
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# For zsh autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# For zsh autocomplete
# source $(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

#### Custom Config ####

# For mutliple neovim/neovide config
# ref: 
# 1. https://gist.github.com/elijahmanor/b279553c0132bfad7eae23e34ceb593b
# 2. https://www.youtube.com/watch?v=LkHjJlSgKZY&ab_channel=ElijahManor
alias nvim-raw="NVIM_APPNAME=nvim-raw nvim"

function nvims() {
  items=("default" "nvim-raw")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config > " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

# yazi
function ya() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# fzf
eval "$(fzf --zsh)"
set rtp+=/opt/homebrew/opt/fzf

# zoxide
eval "$(zoxide init zsh)"

