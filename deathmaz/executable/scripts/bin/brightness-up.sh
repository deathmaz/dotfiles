#!/bin/bash
#increase monitor brightness

curval=`xbacklight`
curval=${curval%.*}
curval=$(expr $curval + 1)

if [ $curval -ge 100 ]; then
    echo already max
else
    xbacklight -time 1 -set `echo $(expr $curval + 5)`
fi
