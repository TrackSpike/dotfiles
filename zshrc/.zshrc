export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git macos)

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

# Loading Tools
eval "$(atuin init zsh)"
eval "$(zoxide init zsh --cmd cd)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
