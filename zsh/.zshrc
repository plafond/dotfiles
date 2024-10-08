# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#
 ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)
source $ZSH/oh-my-zsh.sh


setopt histignorealldups sharehistory
HISTSIZE=100000
SAVEHIST=100000
  HISTFILE=~/.zsh_history


alias ll='ls -lra'
alias la='eza --long --icons --git --all'
alias vim='nvim'
alias v='nvim'

#
alias lt='eza --long --tree --icons --git'

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line


#wget
#function _wget() { curl "${1}" -o $(basename "${1}") ; };
#alias wget='_wget'

#lsd/eza replaces ls
#if [[ -n `lsd` ]]; then
   alias ls='eza'
#end

  ## sometimes batcat - depends on OS/distro
#bat replace cat
  alias cat='bat'


#nvim
  export PATH="$PATH:/opt/nvim/bin"


#node
#:export PATH=$PATH:/Users/pat/Workspace/NODE/node-v20.11.1-darwin-arm64/bin

#flutter and dart
#export PATH=$PATH:/Users/pat/Workspace/SDK/flutter/bin

#melos
export PATH="$PATH":"$HOME/.pub-cache/bin"

#zoxide and batcat
eval "$(zoxide init zsh)"

#
export PATH="$PATH":"$HOME/.local/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
