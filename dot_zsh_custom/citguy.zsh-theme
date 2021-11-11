# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html for more info

# TODO: figure out a better way to include conditional space with ephemeral info

ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_SUFFIX="]"

# show if I'm currently running a VIM shell
function citguy_vimsh() {
  [[ -n $VIM ]] && echo -n "%S<vim:sh>%s "
}

# show git info (if any)
function citguy_git() {
  [[ -n "$(git_prompt_info)" ]] && echo -n "$(git_prompt_info) "
}

# show bg jobs (if any)
function citguy_jobs() {
  #  0 jobs: ""
  # 1+ jobs: "<bg:{jobs}>"
  echo -n "%(1j.%S<bg:%j>%s .)"
}

function citguy_lastcode() {
  # [✔] zero (success)
  # [✘] non-zero
  echo -n "[%(?.\u2714.\u2718)]"
}

# currently unused
function citguy_time() {
  # "May 10, 19:45:06"
  #echo -n "%D{%b %d, %H:%M:%S}"

  # "19:45:06"
  echo -n "%D{%H:%M:%S}"
}


function citguy_build_lprompt() {
  local line1="%n@%m:%4~"
  local line2="$(citguy_lastcode) $(citguy_git)$(citguy_vimsh)%#"
  echo -n "\n$line1\n$line2 "
}
function citguy_build_rprompt() {
  echo -n "$(citguy_jobs)"
}

PROMPT='$(citguy_build_lprompt)'
RPROMPT='$(citguy_build_rprompt)'
