alias ls="ls -hFTG"
alias :q="exit"
alias env="env | sort"
alias be='PRY_AP=0 bundle exec'

if which nodenv > /dev/null
then
  eval "$(nodenv init -)";
fi
