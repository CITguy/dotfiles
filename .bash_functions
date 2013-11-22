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
  #sudo /etc/rc.d/httpd $1
  sudo rc.d $1 httpd
}
#end:apachedo()

function mysqldo() {
  #sudo /etc/rc.d/mysqld $1
  sudo rc.d $1 mysqld
}
#end:mysqldo()

function re_source() {
  source $HOME/.bashrc
}

function long_msg() {
  echo -e "
    Dictumst placerat, amet. In et montes augue nisi etiam porta, montes egestas,
    tincidunt lectus augue nisi cursus nunc! Sit augue, mauris pellentesque, placerat cursus,
    massa duis dignissim integer, nunc? Nunc augue duis tincidunt porta. Ultrices montes diam
    pulvinar montes et lectus, nec pulvinar sociis integer habitasse ac adipiscing ultricies
    adipiscing odio sagittis mauris magna cras eros aliquet tincidunt aliquet scelerisque,
    tempor a enim placerat scelerisque est! Purus cras! Placerat! Nec, amet, sociis, parturient
    elementum tristique lacus placerat lacus tincidunt duis! Urna, lundium nunc nisi in
    ultrices, turpis placerat. Ac porttitor a ultrices tristique aliquam cursus! Porttitor
    facilisis et urna! Lorem integer a, non sociis pid, elementum. Elementum in a ac eu vel
    scelerisque porttitor hac egestas nisi pulvinar lorem sagittis."
  echo "script: $0"
}

function flush_dns() {
  sudo nscd -i hosts
}

function unicornify() {
  unicorn_dir=$HOME/www/unicorn
  proj_dir=/srv/http/$1
  # Check for required directories
  if [ -d $proj_dir ] && [ -d "$proj_dir/config" ];
  then
    # ensure start_unicorn script exists
    sudo ln -sf $unicorn_dir/start_unicorn $proj_dir

    # ensure unicorn configuration exists
    sudo ln -sf $unicorn_dir/config/unicorn.rb $proj_dir/config

    # Restart ensures that previous unicorns are put down before
    # making new ones
    sudo /etc/rc.d/unicorn $1 restart

    sudo /etc/rc.d/nginx restart
  else
    echo "project NOT qualified"
  fi
}

function aa_power_settings () {
  sudo bash -c '
    for i in `find /sys/devices -name "bMaxPower"`;
    do
      for ii in `find $i -type f`;
      do
        bd=`dirname $ii`;
        busnum=`cat $bd/busnum`;
        devnum=`cat $bd/devnum`;
        title=`lsusb -s $busnum:$devnum`;
        echo -e "\n\n+++ $title\n  -$bd\n  -$ii";
        for ff in `find $bd/power -type f ! -empty 2>/dev/null`;
        do
          v=`cat $ff 2>/dev/null|tr -d "\n"`;
          [[ ${#v} -gt 0 ]] && echo -e " `basename $ff`=$v";
          v=;
        done | sort -g;
      done;
    done;
    echo -e "\n\n\n+++ Kernel Modules\n";
    for m in `command lspci -k|sed -n "/in use:/s,^.*: ,,p"|sort -u`;
    do
      echo "+ $m";
      systool -v -m $m 2> /dev/null | sed -n "/Parameters:/,/^$/p";
    done
  ';
}

function caps_escape() {
  setxkbmap -option caps:escape
}

function let_there_be_light() {
  xbacklight -set 100
}

function hg_branch() {
  hg branch 2> /dev/null | awk '{ print " (hg: "$1")" }'
}

function git_branch() {
  git branch 2> /dev/null | awk '{ print " (git: "$2")" }'
}

function sc_branch() {
  hg_branch
  git_branch
}

function detect_displays() {
  $HOME/scripts/auto_xrandr &
  # reset Tint
  killall tint2
  tint2 &
  # reset wallpaper
  nitrogen --restore &
}
