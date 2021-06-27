sudo su
sudo useradd -D
sudo useradd admin
echo "test" | sudo passwd admin --stdin
sudo useradd moderator -g admin
echo "test" | sudo passwd moderator --stdin
sudo useradd user001
echo "test" | sudo passwd user001 --stdin
sudo useradd user002
echo "test" | sudo passwd user002 --stdin
sudo useradd user003
echo "test" | sudo passwd sudo --stdin


[root@hw015 vagrant]# cat /etc/pam.d/sshd | grep pam_nologin
account    required     pam_nologin.so
[root@hw015 vagrant]# cat /etc/pam.d/sshd | grep pam_time

sed -i 's@pam_nologin.so@pam_nologin.so\naccount    required     pam_time.so@g' /etc/pam.d/sshd
cat /etc/pam.d/sshd | grep pam_time
account    required     pam_time.so


cat /etc/group | grep ^admin:

awk -F':' '{print $1":"$4}' /etc/passwd | grep < awk -F':' '/^admin:/{print $3}' /etc/group
grep '^admin:.*$' /etc/group | cut -d: -f4

awk -F':' '{print $1":"$4}' /etc/passwd | grep `awk -F':' '/^admin:/{print $3}' /etc/group` | sed ':b;$2!{N;bb};s/\n/,/g'
awk -F':' '{print $1":"$4}' /etc/passwd | grep `awk -F':' '/^admin:/{print $3}' /etc/group` | awk -F':' '{print $1}' | sed ':b;$2!{N;bb};s/\n/,/g'
 awk -F':' '{print $1":"$4}' /etc/passwd | grep `awk -F':' '/^admin:/{print $3}' /etc/group` | awk -F':' '{print $1}' | tr '\n' ',' |
 awk -F':' '{print $1":"$4}' /etc/passwd | grep `awk -F':' '/^admin:/{print $3}' /etc/group` | awk -F':' '{print $1}' |  awk '{print}' ORS=';'


echo '*;*;admin;Al'  >> /etc/security/time.conf
awk -F':' '{print $1":"$4}' /etc/passwd | grep `awk -F':' '/^admin:/{print $3}' /etc/group` | awk -F':' '{print $1}' | sed ':b;$!{N;bb};s/\n/|/g' | awk '{print "*;*;!|"$0";AlStSn"}' >> /etc/security/time.conf
cat /etc/security/time.conf | grep admin

awk -F':' '{print $1":"$4}' /etc/passwd | grep `awk -F':' '/^admin:/{print $3}' /etc/group | awk -F':' '{print $1}' | sed ':b*;*;user001;$!{N;bb};s/\n/|/g '` >> /etc/security/time.conf
sudo su
echo '*;*;admin;Al'  >> /etc/security/time.conf

vagrant ssh login -u user002


awk: cmd. line:1: {print "*;*;!|"$0";AlStSn"
awk: cmd. line:1:                           ^ unexpected newline or end of string
[root@hw015 ~]# awk -F':' '{print $1":"$4}' /etc/passwd | grep `awk -F':' '/^admin:/{print $3}' /etc/group` | awk -F':' '{print $1}' | sed ':b;$!{N;bb};s/\n/|/g' | awk '{print "*;*;!|"$0";AlStSn"
}' >> /etc/security/time.conf
[root@hw015 ~]# awk -F':' '{print $1":"$4}' /etc/passwd | grep `awk -F':' '/^admin:/{print $3}' /etc/group` | awk -F':' '{print $1}' | sed ':b;$!{N;bb};s/\n/|/g' | awk '{print "*;*;!|"$0";AlStSn"}' >> /etc/security/time.conf
[root@hw015 ~]# cat^C
[root@hw015 ~]#
[root@hw015 ~]# echo '*;*;admin;Al'  >> /etc/security/time.conf
[root@hw015 ~]# cat /etc/security/time.conf | grep admin
#*;*;admin;Al
admin:1001
*;*;!|porter|moderator|admin;AlStSn
(reverse-i-search)`ssh': cat /etc/pam.d/^Chd | grep pam_time
[root@hw015 ~]# ssh ^C
[root@hw015 ~]# ssh admin@127.0.0.1time.conf
admin@127.0.0.1's password:
Last failed login: Sat Jun 26 23:33:40 UTC 2021 from 127.0.0.1 on ssh:notty
There were 5 failed login attempts since the last successful login.
[admin@hw015 ~]$ exit
logout
Connection to 127.0.0.1 closed.
[root@hw015 ~]# ssh moderator@127.0.0.1
moderator@127.0.0.1's password:
Last failed login: Sat Jun 26 22:44:11 UTC 2021 on pts/0
There was 1 failed login attempt since the last successful login.
[moderator@hw015 ~]$ exit
logout
Connection to 127.0.0.1 closed.
[root@hw015 ~]# ssh user001@127.0.0.1
user001@127.0.0.1's password:
Last failed login: Sat Jun 26 23:21:57 UTC 2021 from 127.0.0.1 on ssh:notty
There were 4 failed login attempts since the last successful login.
[user001@hw015 ~]$ exit
logout
Connection to 127.0.0.1 closed.
[root@hw015 ~]# date
Sat Jun 26 23:55:41 UTC 2021
[root@hw015 ~]# datedate -s "2 OCT 2006 18:00:00"^C
[root@hw015 ~]# date -s "2 OCT 2006 18:00:00"
Mon Oct  2 18:00:00 UTC 2006
[root@hw015 ~]# date
Mon Oct  2 18:00:03 UTC 2006
[root@hw015 ~]# ssh user001@127.0.0.1
user001@127.0.0.1's password:
Last login: Sat Jun 26 23:55:35 2021 from 127.0.0.1
[user001@hw015 ~]$ exit
logout
Connection to 127.0.0.1 closed.
[root@hw015 ~]# ssh user002@127.0.0.1
user002@127.0.0.1's password:
Last failed login: Sat Jun 26 23:21:46 UTC 2021 from 127.0.0.1 on ssh:notty
There were 3 failed login attempts since the last successful login.
[user002@hw015 ~]$ exit
logout
Connection to 127.0.0.1 closed.
[root@hw015 ~]# date -s "8 OCT 2006 18:00:00"
Sun Oct  8 18:00:00 UTC 2006
[root@hw015 ~]# ssh user002@127.0.0.1
user002@127.0.0.1's password:
Last failed login: Sat Jun 26 23:21:46 UTC 2021 from 127.0.0.1 on ssh:notty
There were 3 failed login attempts since the last successful login.
Last login: Mon Oct  2 18:00:40 2006 from 127.0.0.1
[user002@hw015 ~]$ exit
logout
Connection to 127.0.0.1 closed.
[root@hw015 ~]# ssh user001@127.0.0.1
user001@127.0.0.1's password:
Last failed login: Sat Jun 26 23:21:57 UTC 2021 from 127.0.0.1 on ssh:notty
There were 4 failed login attempts since the last successful login.
Last login: Mon Oct  2 18:00:17 2006 from 127.0.0.1
[user001@hw015 ~]$ exit
logout
Connection to 127.0.0.1 closed.
[root@hw015 ~]# date
Sun Oct  8 18:00:44 UTC 2006
[root@hw015 ~]#

porter@127.0.0.1's password:
Permission denied, please try again.ime.conf
porter@127.0.0.1's password:
Permission denied, please try again.
porter@127.0.0.1's password:

[root@hw015 ~]# ssh moderator@127.0.0.1
moderator@127.0.0.1's password:
Authentication failed.
[root@hw015 ~]#

