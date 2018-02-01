#!/bin/bash
cat << EOF
Creating fake log files to test logrotate.

EOF

if [[ -z $1 ]]
then
    echo "A base for the logname would be higly appreciated"
    echo
    exit 1
else
    logname=$1
fi


for x in "" ".1" ".2" 
do 
    for log in err out
    do 
        echo $log $x
        echo $(($(date +'%s * 1000 + %-N / 1000000') + $RANDOM)): $(date) > ${logname}.${log}${x}
    done
done
