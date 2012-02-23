# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
#[ -z "$PS1" ] && return

# Start SSH Agent
#agent_count=ps -e | grep ssh-agent | wc -l
#if [[ $agent_count -eq 0 ]] ; then
#  # Prevents me from needing to enter a password for SSH Key Authentication
#  echo "Start SSH Agent"
#  #ssh-agent $SHELL
#fi

archbey -c black


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
      . /etc/bash_completion
  fi

  ################################################################################ 
  ## YOUR CUSTOM SETTINGS
  ################################################################################ 
  export PATH=$PATH:/home/ryan/BIN:/home/ryan/bin
  export HG_CLI_TMP_PATH=/home/ryan/LIB/config/mercurial-cli-templates
  export ANT_HOME=/home/ryan/BIN/sit/tools/ant
  export JAVA_HOME=/opt/java
  export PATH=$ANT_HOME/bin:$JAVA_HOME/bin:$PATH

  export WSFC_HOME=/opt/wsf/c

  txtrst="\[\e[0m\]"

  PS1="${txtrst}\[\e[7m\][\u@\h:\w]\$${txtrst} "

  # Alias definitions.
  # You may want to put all your additions into a separate file like
  # ~/.bash_aliases, instead of adding them here directly.
  # See /usr/share/doc/bash-doc/examples in the bash-doc package.
  # Load Bash Aliases if it exists
  if [ -f ~/.bash_aliases ]; then
      . ~/.bash_aliases
  fi

  # some more ls aliases
  alias ls='ls --color=auto'
  alias ll='ls -alF'
  alias nautilus='nautilus --no-desktop'
  alias :q='exit'
  alias open='xdg-open'
  #alias pacman='pacman-color'

  # Load Special Bash Prompt
  if [ -f "$HOME/.bash_ps1" ]; then
    . "$HOME/.bash_ps1"
  fi
fi

[[ -s "/home/ryan/.rvm/scripts/rvm" ]] && source "/home/ryan/.rvm/scripts/rvm"  # This loads RVM into a shell session

function cfctl() {
  case $1 in
    start)
      apachedo restart
      cfdo start
      ;;
    stop)
      # keep apache running
      cfdo stop
      ;;
    restart)
      apachedo restart &&
      cfdo restart
      ;;
    *)
      # do nothing
      ;;
  esac
  #tail -f /opt/coldfusion9/logs/cfserver.log
}
#end:cfctl()

function cfdo() {
  sudo /opt/coldfusion9/bin/coldfusion $1
}

function apachedo() {
  # Ubuntu
  #sudo /etc/init.d/apache2 $1
  # Arch
  sudo /etc/rc.d/httpd $1
}
#end:apachedo()

function regnomedo() {
  killall gnome-do
  gnome-do &> /dev/null
}
#end:regnomedo()

function mysqldo() {
  # Arch
  sudo /etc/rc.d/mysqld $1
}
#end:mysqldo()

# ArchBang: WORKS! (need 'net-tools'package)
# Ubuntu: Works!
function change_gw() {
  case $1 in
    1)
        sudo route del default;
        sudo route add default gw 10.10.20.2;;
    2)
        sudo route del default;
        sudo route add default gw 10.10.20.1;;
    *)
        echo "Usage: change_gw [1|2]";;
  esac
}
#end:change_gw()

# Should work (O_o)
function getIntelFeed() {
  cd /home/ryan/BIN/Intel/HRFeed/AssociateConnect_Linux/bin # go to bin location
  sh ./receive.sh # run script
  cd - # go back from whence ye came!
}
#end:getIntelFeed

function runIntelFeed() {
  cd /home/ryan/www/intel # go to intel directory
  cap maintenance:hr_update RAILS_ENV=production FILE=/home/ryan/BIN/Intel/HRFeed/AssociateConnect_Linux/data/fromhub/INTEL_NCFCPP_PROD/BFDetail_ww${1}.zip # Run cap task
  cd - # go back from whence ye came!
}
#end:runIntelFeed()

function gemset() {
  rvm gemset use $1
}
#end: gemset

function sync_intel_with_ticket() {
  curl -X POST https://solutions.bluefishwireless.net/intel/update_tickets/crm_sync -d p=blu3fiSh -d ticket_number=$1
  echo -e "\n"
}
#sync_intel_with_ticket

function re_source() {
  source /home/ryan/.bashrc
}

function make_private() {
  chmod 700 $1
}
