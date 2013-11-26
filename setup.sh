#!/bin/bash

# 2013-11-26: Currently configured for OSX setup
# TODO:
# [ ] Platform detection
#
# The following directories will need handled manually
#   .config/
#   scripts/

srcDir="$HOME"
targetDir="$srcDir"

################################################################################
## SUPPORTING FUNCTIONS
################################################################################
function backupFiles() {
  file_list=(
    .ackrc
    .autotest
    .bash_aliases
    .bash_colors
    .bash_functions
    .bashrc
    .caprc
    .conkyrc
    .gemrc
    .hgrc
    .irbrc
    .xinitrc
    .yaourtrc
  )
  bkupDir="${targetDir}/.backups_`date '+%y%m%d-%H%M'`"
  mkdir -p $bkupDir

  for bf in "${file_list[@]}"
  do
    if [ -e "${srcDir}/${bf}" ]
    then
      # timestamped to prevent clobbering older backups
      cp ${srcDir}/${bf} ${bkupDir}/${bf}
    fi
  done
}
#backupFiles


# This is for configs to be COPIED (not symlinked)
function copyConfigs() {
  file_list=(
    .ackrc
    #.autotest
    .bash_aliases
    .bash_colors
    .bash_functions
    .bashrc
    .caprc
    #.conkyrc
    .gemrc
    #.hgrc
    #.irbrc
    #.xinitrc
    #.yaourtrc
  )
  for bf in "${file_list[@]}"
  do
    cp ${srcDir}/${bf} ${targetDir}/${bf}
  done
}
#copyConfigs


################################################################################
## MAIN EXECUTION SEQUENCE
################################################################################
backupFiles
copyConfigs
