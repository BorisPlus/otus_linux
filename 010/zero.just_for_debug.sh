

 grep -P '\[[0-9]{2}]/\w*/[0-9]{4}:[0-9]{2}:[0-9]{2}.*[0-9]{2} +0300]' access-4560-644067.log

cat access-4560-644067.log | awk 'BEGIN { FS = " ["; sd = "14/Aug/2019:01:38:37 +0300]"; ed = "14/Aug/2019:04:38:37 +0300["; } $2 >= sd && $2 <= ed'
awk 'BEGIN {print strftime("Time = %m/%d/%Y %H:%M:%S", systime())}'


 grep -P '\[[0-9]{2}]\/\w*\/[0-9]{4}:[0-9]{2}:[0-9]{2}.*[0-9]{2} +0300]' access-4560-644067.log

grep -P '\[[0-9]{2}/\w*/[0-9]{4}:[0-9]{2}:[0-9]{2}:[0-9]{2}' access-4560-644067.log
grep -P '\[\w\]' access-4560-644067.log | awk '{print $1}'


grep "$(date -d '600 day ago' +'%b %d'| sed 's/0//')" access-4560-644067.log
