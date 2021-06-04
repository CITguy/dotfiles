export EDITOR='vim'
export PATH=$PATH:$HOME/bin
export SSH_KEY_PATH="~/.ssh/id_rsa"

alias ls="ls -hFTG"
alias :q="exit"
alias env="env | sort"
alias be='PRY_AP=0 bundle exec'
alias cm="chezmoi"


## nodenv config
if which nodenv > /dev/null
then
  eval "$(nodenv init -)";
fi

## rbenv config
if which rbenv > /dev/null
then
  #export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi
