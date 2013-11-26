function re_source() {
  source $HOME/.bash_profile
}

function git_branch() {
  git branch 2> /dev/null | grep "*" | awk '{ print " (git: "$2")" }'
}


function hg_branch() {
  hg branch 2> /dev/null | awk '{ print " (hg: "$1")" }'
}


function sc_branch() {
  hg_branch
  git_branch
}

# Jot Down (jd)
# @arg filename ('scratch')
function jd() {
  mkdir -p $HOME/workspace/notes
  $EDITOR $HOME/workspace/notes/${1-scratch}.txt
}
