#~/bin/bashi
last=20200315
while true 
do
  cur=`date +%Y%m%d`
  if [ "$last" != "$cur" ]; then
    date
    ./autofill.sh
    last=$cur
  fi
  sleep 1h
done
