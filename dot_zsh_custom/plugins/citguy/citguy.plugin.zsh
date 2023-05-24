## NOTE: depends on the `brew` plugin, for homebrew binaries to be available

#========================================#
# ENVIRONMENT VARIABLES
#========================================#
export PATH=$PATH:$HOME/bin # TODO: only modify if `$HOME/bin` is NOT in $PATH
export CHEZMOI_PATH="~/.local/share/chezmoi"
export EDITOR="vim"
export SSH_KEY_PATH="~/.ssh/id_rsa"


#========================================#
# ALIASES
#========================================#
alias ls="ls -hFTG"
alias :q="exit"
alias env="env | sort"
alias be='PRY_AP=0 bundle exec'
alias cm="chezmoi"
alias :dotfiles="cd $CHEZMOI_PATH"


#========================================#
# INITIALIZATION
#========================================#

# nodenv config
if which nodenv > /dev/null
then
  # will add $HOME/.nodenv/shims to your PATH
  eval "$(nodenv init -)";
fi

# rbenv config
if which rbenv > /dev/null
then
  eval "$(rbenv init -)"
fi
