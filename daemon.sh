#!/bin/bash
mkdir -p tmp
touch tmp/last
last=$(cat tmp/last)
echo "Last submit was at $last"
while true; do
  cur=`date +%Y%m%d`
  if [ "$last" != "$cur" ]; then
    while true; do
      ./autofill.sh
      if [ $? != 0 ]; then
        echo `date`:" Wait for 1 minute and try"
        sleep 1m
      else
        echo `date`:" Success"
        echo $cur > tmp/last
        last=$cur
        break
      fi
    done
  else
    echo `date`:" Submitted today"
  fi
  sleep 1h
done
