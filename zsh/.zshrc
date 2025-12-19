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

# plugins=(aws git git-extras zsh-autosuggestions zsh-syntax-highlighting web-search kubectl kube-ps1 docker docker-compose vi-mode uv terraform pyenv python k9s fzf node yarn)
# source $ZSH/oh-my-zsh.sh


setopt histignorealldups sharehistory
HISTSIZE=100000
SAVEHIST=100000
  HISTFILE=~/.zsh_history


setopt VI

alias ll='ls -la -s changed'
alias la='eza --long --icons --git --all'
alias vim='nvim'
alias v='nvim'

#
alias lt='eza --long --tree --icons --git'

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

#vi-mode
# bindkey -v
# export KEYTIMEOUT=1

#wget
#function _wget() { curl "${1}" -o $(basename "${1}") ; };
#alias wget='_wget'

#lsd/eza replaces ls
#if [[ -n `lsd` ]]; then
   alias ls='eza'
#end

  ## sometimes batcat - depends on OS/distro
#bat replace cat
  alias cat='batcat'
  alias cap='cat -p'

  alias clip='xclip -sel clip'

#nvim
  export PATH="$PATH:/opt/nvim/bin"


#
alias d="docker"
alias k="kubectl"
alias al="awslocal"
alias cg="cat $1 | grep $2"
alias hg="history | grep"
alias lsd="localstack start -d"
alias vpn-on="protonvpn connect --country CA"
alias vpn-off="protonvpn disconnect"

#node
#:export PATH=$PATH:/Users/pat/Workspace/NODE/node-v20.11.1-darwin-arm64/bin

#flutter and dart
#export PATH=$PATH:/Users/pat/Workspace/SDK/flutter/bin

# PERSONAL GEMINI API KEY

# Kubernetes Configuration
export KUBECONFIG="${HOME}/.kube/config"
# LocalStack Source Code Paths
export LOCALSTACK_COMMUNITY_PATH="/w/ls/localstack"
export LOCALSTACK_PRO_PATH="/w/ls/localstack-ext"
# GitHub Configuration
export GITHUB_PERSONAL_ACCESS_TOKEN="your_github_token_here"


# Minikube Configuration
export MINIKUBE_HOME="${HOME}/.minikube"

export LOCALSTACK_K8S_OPERATOR_PATH="/w/ls/localstack-k8s-operator"

#melos
export PATH="$PATH":"$HOME/.pub-cache/bin"

#zoxide and batcat
eval "$(zoxide init zsh)"

# Set up fzf key bindings and fuzzy completion
#source <(fzf --zsh)

#
export PATH="$PATH":"$HOME/.local/bin"
export QT_QPA_PLATFORMTHEME=qt5ct

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
# [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"


export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"


export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

eval "$(pyenv virtualenv-init -)"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


#autoload -Uz zrecompile

# Added by LocalStack installer
source $HOME/.localstack/localstack_setup.sh

# hack - aws_completer
PATH="$PATH:/snap/aws-cli/current/bin/"

complete -C aws_completer aws

plugins=(git git-extras zsh-autosuggestions zsh-syntax-highlighting web-search aws kubectl kube-ps1 docker docker-compose vi-mode uv terraform pyenv python k9s fzf node yarn zsh-completions)

autoload -Uz compinit && compinit -C -i

zmodload -i zsh/complist

#source ~/somewhere/fzf-tab.plugin.zsh


source $HOME/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.plugin.zsh
#completion/zsh/fzf-zsh-completion.sh

#zstyle ':completion:*:*:aws:*' fzf-search-display true
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath' # preview directory contents with cd
zstyle ':fzf-tab:complete:z:*' fzf-preview 'ls --color $realpath' # preview directory contents with zoxide
zstyle ':fzf-tab:complete:ll:*' fzf-preview 'cat $realpath --style=numbers --color=always --line-range :500 {}'
zstyle ':fzf-tab:complete:la:*' fzf-preview 'cat $realpath --style=numbers --color=always --line-range :500 {}'
zstyle ':fzf-tab:complete:v:*' fzf-preview 'cat $realpath --style=numbers --color=always --line-range :500 {}'
#zstyle ':fzf-tab:complete:aws:*' fzf-preview 'aws $selected_command help' # preview aws command help
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' use-fzf-default-opts yes # use FZF_DEFAULT_OPTS for fzf-tab
 
#zstyle ':completion:*' completer _extensions _complete _approximate

# only aws command completion 
#zstyle ':completion:*:*:aws:*' fzf-search-display true
# or for everything
#zstyle ':completion:*' fzf-search-display false
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match


#Setup fuzzy finder
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#424762,spinner:#b0bec5,hl:#f78c6c \
# --color=fg:#bfc7d5,header:#ff9e80,info:#82aaff,pointer:#a5adce \
# --color=marker:#89ddff,fg+:#eeffff,prompt:#c792ea,hl+:#ff9e80 \
# --color=selected-bg:#424762"


### DARKULA
# export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

# https://vitormv.github.io/fzf-themes#eyJib3JkZXJTdHlsZSI6InJvdW5kZWQiLCJib3JkZXJMYWJlbCI6IiIsImJvcmRlckxhYmVsUG9zaXRpb24iOjAsInByZXZpZXdCb3JkZXJTdHlsZSI6InJvdW5kZWQiLCJwYWRkaW5nIjoiMCIsIm1hcmdpbiI6IjAiLCJwcm9tcHQiOiI+ICIsIm1hcmtlciI6Ij4iLCJwb2ludGVyIjoi4peGIiwic2VwYXJhdG9yIjoi4pSAIiwic2Nyb2xsYmFyIjoi4pSCIiwibGF5b3V0IjoiZGVmYXVsdCIsImluZm8iOiJkZWZhdWx0IiwiY29sb3JzIjoiZmc6I2QwZDBkMCxmZys6I2VkODg4OCxiZzojMmEzMDMxLGJnKzojMjYyNjI2LGhsOiMxNGUxMjksaGwrOiM3NGZmNWUsaW5mbzojYWZhZjg3LG1hcmtlcjojY2M1YTE0LHByb21wdDojZDcwMDVmLHNwaW5uZXI6I2FmNWZmZixwb2ludGVyOiNhZjVmZmYsaGVhZGVyOiMzNzYxZWEsYm9yZGVyOiM4ZDE1NzksbGFiZWw6I2FlYWVhZSxxdWVyeTojY2JlYzc3In0=
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#d0d0d0,fg+:#ed8888,bg:#2a3031,bg+:#262626
  --color=hl:#14e129,hl+:#74ff5e,info:#afaf87,marker:#cc5a14
  --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#3761ea
  --color=border:#8d1579,label:#aeaeae,query:#cbec77
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'


export ZSH_THEME_AWS_PROFILE_PREFIX=""
export ZSH_THEME_AWS_PROFILE_SUFFIX=""
export ZSH_THEME_AWS_REGION_PREFIX=""
export ZSH_THEME_AWS_REGION_SUFFIX=""
export ZSH_THEME_AWS_DIVIDER=" | "

source $ZSH/oh-my-zsh.sh
#exec asp ls

# opencode
export PATH=/home/pat/.opencode/bin:$PATH


