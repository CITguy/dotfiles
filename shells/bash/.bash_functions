function re_source() {
  source $HOME/.bash_profile
}

function git_branch() {
  git branch 2> /dev/null | grep "*" | awk '{ print " (git: "$2")" }'
}


function mongoctl() {
  pid=`ps aux | grep "mongod\.conf" | awk '{ print $2 }'`
  case "$1" in
    "start")
      mongod --dbpath $HOME/workspace/data/db &> /dev/null &
      ;;
    "stop")
      kill -9 $pid
      ;;
    "status")
      if [ -n "$pid" ]
      then
        echo "RUNNING $pid"
      else
        echo "STOPPED"
      fi
      ;;
  esac
}
#mongoctl

# Jot Down (jd)
# @arg filename ('scratch')
function jd() {
  notes_dir="${HOME}/workspace/notes"
  mkdir -p $notes_dir
  $EDITOR ${notes_dir}/${1-scratch}.txt
}
