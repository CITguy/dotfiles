# If not running interactively, don't do anything
#[[ -z "$PS1" ]] && return

[[ -e "${HOME}/.bash_colors" ]] && source "${HOME}/.bash_colors"
[[ -e "${HOME}/.bash_functions" ]] && source "${HOME}/.bash_functions"
[[ -f "${HOME}/.bash_aliases" ]] && source "${HOME}/.bash_aliases"

# Git Completion
[[ -e "${HOME}/scripts/git-completion.bash" ]] && source "${HOME}/scripts/git-completion.bash"

################################################################################
## MY CUSTOM SETTINGS
################################################################################
export PATH=$PATH:$HOME/bin
export EDITOR="vim"
## don't put duplicate lines in the history. See bash(1) for more options
## don't overwrite GNU Midnight Commander's setting of `ignorespace'.
#HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
## ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth
export HISTSIZE=1000
export HISTFILESIZE=5000

### OVERLY COMPLICATED BASH PROMPT
blk="\342\226\210" #\342\226\210"
ps1_jobs="${bldred}\j${txtrst}"
ps1_time="${txtrst}\d, \@${txtrst}"
ps1_base="[${ps1_jobs}:${bld}\u${txtrst}] (${ps1_time})"
ps1_passfail="\$(if [[ \$? == 0 ]]; then echo \"${txtgrn}\"; else echo \"${txtred}\"; fi)${blk}${txtrst}"
ps1_cmd_stat="(^${bld}\$?${txtrst})"
ps1_cmd_hist="(${txtrst}\!${txtrst})"
ps1_branching="${bldpur}\$(git_branch)${txtrst}"
ps1_dir="${ps1_cmd_hist}[${bldylw}\w${txtrst}]"
ps1_vim_shellout=${VIM:+"[vim:sh]"}
PS1="\n${txtrst}${ps1_passfail} ${ps1_base}${ps1_branching} ${ps1_vim_shellout}\n${ps1_dir}\$ ${txtrst}"
### end:OVERLY COMPLICATED BASH PROMPT

# modify path for Homebrew
export PATH=/usr/local/bin:$PATH

# initailzie RBENV
eval "$(rbenv init -)"
