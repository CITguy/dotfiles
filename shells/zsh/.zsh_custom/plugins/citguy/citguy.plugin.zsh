alias ls="ls -hFTG"
alias :q="exit"
alias env="env | sort"

if which nodenv > /dev/null
then
  eval "$(nodenv init -)";
fi
