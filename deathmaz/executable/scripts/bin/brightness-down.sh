#!/bin/bash
#decrease monitor brightness

curval=`xbacklight`
curval=${curval%.*}
curval=$(expr $curval + 1)

if [ $curval -le 4 ]; then
    echo already min
else
    xbacklight -time 1 -set `echo $(expr $curval - 5)`
fi
