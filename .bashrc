# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ -z "$PS1" ]] && return

# remap capslock to ESC
setxkbmap -option caps:escape &

if [[ -n "$PS1" ]] ; then
  # don't put duplicate lines in the history. See bash(1) for more options
  # don't overwrite GNU Midnight Commander's setting of `ignorespace'.
  HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
  # ... or force ignoredups and ignorespace
  HISTCONTROL=ignoreboth

  # append to the history file, don't overwrite it
  shopt -s histappend

  # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
  HISTSIZE=1000
  HISTFILESIZE=2000

  # check the window size after each command and, if necessary,
  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize

  # make less more friendly for non-text input files, see lesspipe(1)
  [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

  # set variable identifying the chroot you work in (used in the prompt below)
  if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
      debian_chroot=$(cat /etc/debian_chroot)
  fi

  # set a fancy prompt (non-color, unless we know we "want" color)
  case "$TERM" in
    xterm-color)
      color_prompt=yes
    ;;
  esac

  if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
      # We have color support; assume it's compliant with Ecma-48
      # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
      # a case would tend to support setf rather than setaf.)
      color_prompt=yes
    else
      color_prompt=
    fi
  fi

  if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  fi

  unset color_prompt force_color_prompt

  # If this is an xterm set the title to user@host:dir
  case "$TERM" in
    xterm*|rxvt*)
      PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
    *)
    ;;
  esac

  # enable color support of ls and also add handy aliases
  if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto -B1'
    alias fgrep='fgrep --color=auto -B1'
    alias egrep='egrep --color=auto -B1'
  fi

  # enable programmable completion features (you don't need to enable
  # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
  # sources /etc/bash.bashrc).
  if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    source /etc/bash_completion
  fi

  ################################################################################
  ## YOUR CUSTOM SETTINGS
  ################################################################################
  export PATH=$PATH:$HOME/BIN:$HOME/bin
  export HG_CLI_TMP_PATH=$HOME/LIB/config/mercurial-cli-templates
  export ANT_HOME=$HOME/BIN/sit/tools/ant
  export JAVA_HOME=/opt/java
  export PATH=$ANT_HOME/bin:$JAVA_HOME/bin:$PATH
  export EDITOR="vim"
  export WSFC_HOME=/opt/wsf/c

  txtrst="\[\e[0m\]"
  PS1="${txtrst}\[\e[7m\][\u@\h:\w]\$${txtrst} "

  # Alias definitions.
  # You may want to put all your additions into a separate file like
  # ~/.bash_aliases, instead of adding them here directly.
  # See /usr/share/doc/bash-doc/examples in the bash-doc package.
  # Load Bash Aliases if it exists
  [[ -f "${HOME}/.bash_aliases" ]] && source "${HOME}/.bash_aliases"

  # Load Special Bash Prompt
  [[ -f "$HOME/.bash_ps1" ]] && source "${HOME}/.bash_ps1"
fi

# Add RVM to PATH for scripting
PATH=$PATH:${rvm_path}/bin
[[ -s "${rvm_path}/scripts/rvm" ]] && source "${rvm_path}/scripts/rvm"  # This loads RVM into a shell session

# RVM bash completion
[[ -r "${rvm_path}/scripts/completion" ]] && source "${rvm_path}/scripts/completion"

# Add additional functions (if file exists)
[[ -e "${HOME}/.bash_functions" ]] && source "${HOME}/.bash_functions"
