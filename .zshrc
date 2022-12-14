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
export PATH=/opt/homebrew/bin:$PATH
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export PATH="$PATH:/Users/andy/.dotnet/tools"
export PATH="$PATH:/Users/andy/Library/Caches/pip"
export PATH=$HOME/.emacs.d/bin:$PATH

# use vim mode in terminal command line
set -o vi

# add to dotfiles
alias dgit="git --git-dir ~/Desktop/dotfiles/.git/ --work-tree=$HOME"

# specify g++ version
alias gcc='gcc-12'
alias cpp='cpp-12'
alias g++='g++-12'
alias c++='c++-12'
export CC='/opt/homebrew/bin/gcc-12'

# open the file in neovim
fn() (
    # export FZF_DEFAULT_COMMAND="fd -p -i -H -L -t f -t l -t x"
    local files
    IFS=$'\n' \
       files=($(fzf --reverse \
                    --preview "bat --theme=timu-spacegrey --color=always {}" \
                    --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && nvim "${files[@]}"
)

# TODO: 要怎麼 cd 到另外的資料夾呢...
ff() (
    local directory
    IFS=$'\n' \
       directory=$(fzf --reverse \
                    --preview "bat --theme=timu-spacegrey --color=always {}" \
                    --query="$1" --multi --select-1 --exit-0) &&
    # directory=$(fzf --reverse \
    #             --preview "bat --theme=timu-spacegrey --color=always {}" \
    #             --query="$1" --multi --select-1 --exit-0) &&
    local dir="$(dirname ${directory[@]})"
    echo "$dir"
    cd "$dir"
)

# cd to the directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
				  -o -type d -print 2> /dev/null | fzf +m) &&
  echo "$dir"
  cd "$dir"
}

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

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
