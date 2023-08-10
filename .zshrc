# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_DISABLE_COMPFIX=true
# If you come from bash you might have to change your $PATH.
# use the bash from homebrew
export PATH="/opt/homebrew/sbin:$PATH"
export PATH=/opt/homebrew/bin:$PATH
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export PATH="$PATH:/Users/andy/.dotnet/tools"
export PATH="$PATH:/Users/andy/Library/Caches/pip"
export PATH="$PATH:/Users/andy/Library/Python/3.8/bin"

# add macvim to path
# ref: https://michaelsoolee.com/launch-macvim-from-terminal/
alias mvim="/Applications/MacVim.app/Contents/bin/mvim"

alias nvid="/Applications/Neovide.app/Contents/MacOS/Neovide"

# add to dotfiles
alias dgit="git --git-dir ~/Desktop/dotfiles/.git/ --work-tree=$HOME"

# specify g++ version
alias gcc='gcc-12'
alias cpp='cpp-12'
alias g++='g++-12'
alias c++='c++-12'
export CC='/opt/homebrew/bin/gcc-12'

# open the file in vim
fv() (
    local files
    IFS=$'\n' \
       files=($(fzf --reverse \
                    --preview "bat --theme=gruvbox-dark --color=always {}" \
                    --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && vim "${files[@]}"
)

# open the file in neovim
fn() (
    local files
    IFS=$'\n' \
       files=($(fzf --reverse \
                    --preview "bat --theme=gruvbox-dark --color=always {}" \
                    --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && nvim "${files[@]}"
)

# Show the preview of files and print the file path
fp() (
    local directory
    IFS=$'\n' \
       directory=$(fzf --reverse \
                    --preview "bat --theme=gruvbox-dark --color=always {}" \
                    --query="$1" --multi --select-1 --exit-0) &&
    # local dir="$(dirname ${directory[@]})"
    # echo "${dir}"
    echo "$directory"
)

# cd to the directory
fdd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
      -o -type d -print 2> /dev/null | fzf --reverse +m) &&
  echo "$dir"
  cd "$dir"

  # NOTE: for ubuntu
  # ref: https://askubuntu.com/questions/481715/why-doesnt-cd-work-in-a-shell-script
  # $SHELL
}

# Open the file in vim with rg
# 1. Search for text in files using Ripgrep
# 2. Interactively narrow down the list using fzf
# 3. Open the file at specific line in Vim
fw() (
    local output=$(
    rg --color=always --line-number --no-heading --smart-case "${*:-}" |
        fzf --delimiter ":" \
        --nth 2.. \
        --reverse \
        --ansi \
        --preview "bat --style=numbers --theme=gruvbox-dark --color=always {} --highlight-line {2} {1}" \
        --preview-window "down:60%:+{2}" \
    )

    local file=$(echo "$output" | cut -d":" -f1)
    local line=$(echo "$output" | cut -d":" -f2)

    [[ ! -z "$file" ]] && vim +"$line" "$file"
)

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

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# thefuck
eval $(thefuck --alias)


# use original vim mode in terminal command line
# set -o vi

# For zsh-vi-mode
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

# For mutliple neovim/neovide config
# ref: 
# 1. https://gist.github.com/elijahmanor/b279553c0132bfad7eae23e34ceb593b
# 2. https://www.youtube.com/watch?v=LkHjJlSgKZY&ab_channel=ElijahManor
alias nvim-raw="NVIM_APPNAME=nvim-raw nvim"
alias nvid-raw="NVIM_APPNAME=nvim-raw neovide"

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

bindkey -s ^a "nvims\n"

function nvids() {
  items=("default" "nvim-raw")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config > " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config neovide $@
}

bindkey -s ^a "nvids\n"
