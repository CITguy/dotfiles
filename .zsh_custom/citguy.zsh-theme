local prompt_base_color="%{$reset_color%}%{$fg_no_bold[white]%}"
local branch_base_color="%{$fg_bold[magenta]%}"
local branch_color="%{$reset_color%}%{$fg_bold[green]%}"
local ruby_base_color="%{$reset_color%}%{$fg_bold[red]%}"
local ruby_color="%{$reset_color%}%{$fg_bold[magenta]%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$branch_base_color%}git[%{$branch_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$branch_base_color%}]%{$reset_color%}"

function citguy_reset() {
  echo -n "%{$reset_color%}%{$prompt_base_color%}"
}
function citguy_user() {
  local k="$(citguy_reset)"
  local thx="%B%n%b"
  local bye="$(citguy_reset)"
  echo -n "$k$thx$bye"
}
function citguy_jobs() {
  local k="$(citguy_reset)"
  local thx="%{$fg_bold[red]%}%j"
  local bye="$(citguy_reset)"
  echo -n "$k$thx$bye"
}
function citguy_time() {
  local k="$(citguy_reset)"
  local thx="%D{%b %d, %H:%M:%S}"
  local bye="$(citguy_reset)"
  echo -n "$k$thx$bye"
}
function citguy_lastcode() {
  local k="$(citguy_reset)"
  local thx="%{$fg_bold[white]%}%?"
  local bye="$(citguy_reset)"
  echo -n "$k$thx$bye"
}
function citguy_histnum() {
  local k="$(citguy_reset)"
  local thx="%!"
  local bye="$(citguy_reset)"
  echo -n "$k$thx$bye"
}
function citguy_path() {
  local k="$(citguy_reset)["
  local thx="%{$fg_bold[black]%}%4~"
  local bye="$(citguy_reset)]"
  echo -n "$k$thx$bye"
}
function citguy_vimsh() {
  if [[ -n $VIM ]]; then
    echo -n " $(citguy_reset)%{$fg_bold[yellow]%}<vim:sh>$(citguy_reset)"
  fi
}
function citguy_git() {
  if [[ -n "$(git_prompt_info)" ]]; then
    echo -n " $(git_prompt_info)"
  fi
}
function citguy_rbenv() {
  local k="%{$ruby_base_color%}rb("
  local thx="%{$ruby_color%}$(rbenv_prompt_info)"
  local bye="%{$ruby_base_color%})"
  echo -n "$k$thx$bye"
}
function citguy_build_lprompt() {
  local line1="[$(citguy_jobs):$(citguy_user)] ($(citguy_time)) $(citguy_path)"
  local line2="[$(citguy_lastcode):$(citguy_histnum)]$(citguy_git)$(citguy_vimsh) %#"
  echo -n "$(citguy_reset)\n$line1\n$line2%{$reset_color%} "
}
function citguy_build_rprompt() {
  echo -n "$(citguy_rbenv)%{$reset_color%}"
}

PROMPT='$(citguy_build_lprompt)'
RPROMPT='$(citguy_build_rprompt)'
