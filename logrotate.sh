#!/bin/bash

# Things to do:
## Add parameters for:
### -l log_name (instead of using the whole ARGV)
### -n number_of_rotate_file_to_keep (it's fixed at 10 now)
### -d debug (some prints)



if [[ -z $1 ]]
then
    echo "Still missing the point..."
    echo "$0 log_to_rotate num_rotations"
    echo
    exit 1
else 
    LOGS="$@"
    NUM=10
fi

function rotate(){
  LOG=$1
  X=${NUM}

  if [[ -e ${LOG}.${X} ]]
  then
        rm -f ${LOG}.${X}
        X=$((${X} - 1))
  fi

  while [[ ${X} -gt 0 ]]
  do
    # echo Checking ${LOG}.${X} 
    if [[ -e ${LOG}.${X} ]]
    then
        mv ${LOG}.$X ${LOG}.$((${X} + 1))
    fi
    X=$((${X} - 1))
  done

  if [[ -e ${LOG} ]]
  then
     mv ${LOG} ${LOG}.1
     touch ${LOG}
  else
    echo "The Log -> ${LOG} <- doesn't exist"
  fi
}




for LOG in $LOGS 
do
  echo "Rotating ${LOG}"
  rotate ${LOG} 
done