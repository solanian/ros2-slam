export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="refined"

plugins=(git k zsh-autosuggestions zsh-syntax-highlighting zsh-completions)

source $ZSH/oh-my-zsh.sh
source /opt/ros/humble/setup.zsh

export DISPLAY=:0