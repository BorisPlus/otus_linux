#  Доступ из сети в Интернет через единый узел

## Реализация

```shell
pwd
# ./0XX_stand/vm
vagrant destroy -f && vagrant up
python3 v2a.py -o ../ansible/inventories/hosts
cd ../ansible/
ansible-playbook playbooks/routing.yml > ../files/playbooks_routing.txt
ansible-playbook playbooks/internet-router.yml  > ../files/internet-router.txt # тут маскарадинг !192.168.0.0/16
ansible-playbook playbooks/test_network_connectivity.yml > ../files/test_network_connectivity.txt
```


<details><summary>см. playbooks/routing.yml</summary>

```text

PLAY [Playbook of ethX gateway config] *****************************************

TASK [Gathering Facts] *********************************************************
ok: [inetRouter]
ok: [centralServer]
ok: [centralRouter]
ok: [office1Server]
ok: [office1Router]
ok: [testClient1]
ok: [office2Server]
ok: [office2Router]
ok: [testServer2]
ok: [testServer1]
ok: [testClient2]

TASK [../roles/routing : /etc/sysconfig/network | "NOZEROCONF=yes" | I don't want 169.254.0.0/16 network at default] ***
changed: [inetRouter]
changed: [centralServer]
changed: [office1Router]
changed: [office1Server]
changed: [centralRouter]
changed: [office2Router]
changed: [office2Server]
changed: [testServer2]
changed: [testClient1]
changed: [testServer1]
changed: [testClient2]

TASK [../roles/routing : /etc/sysconfig/network-scripts/route-* | delete route files] ***
changed: [inetRouter]
changed: [centralRouter]
changed: [centralServer]
changed: [office1Router]
changed: [office1Server]
changed: [office2Router]
changed: [testServer1]
changed: [office2Server]
changed: [testServer2]
changed: [testClient1]
changed: [testClient2]

TASK [../roles/routing : /etc/sysconfig/network-scripts/route-* | create needed route files] ***
changed: [inetRouter] => (item={'interface': 'eth1', 'nw': '192.168.0.0/16', 'via': '192.168.255.2'})
changed: [centralRouter] => (item={'interface': 'eth3', 'nw': '192.168.2.0/24', 'via': '192.168.0.34'})
changed: [centralRouter] => (item={'interface': 'eth3', 'nw': '192.168.1.0/24', 'via': '192.168.0.35'})

TASK [../roles/routing : /etc/sysconfig/network-scripts/route-* | set route] ***
changed: [centralRouter] => (item={'interface': 'eth3', 'nw': '192.168.2.0/24', 'via': '192.168.0.34'})
changed: [inetRouter] => (item={'interface': 'eth1', 'nw': '192.168.0.0/16', 'via': '192.168.255.2'})
changed: [centralRouter] => (item={'interface': 'eth3', 'nw': '192.168.1.0/24', 'via': '192.168.0.35'})

TASK [../roles/routing : /etc/sysconfig/network-scripts/ifcfg-ethX | content] ***
changed: [inetRouter]
changed: [office1Router]
changed: [office1Server]
changed: [centralServer]
changed: [centralRouter]
changed: [office2Router]
changed: [office2Server]
changed: [testServer2]
changed: [testServer1]
changed: [testClient1]
changed: [testClient2]

TASK [../roles/routing : /etc/sysconfig/network-scripts/ifcfg-ethX | GATEWAY=<ip> | set up if did not set] ***
skipping: [inetRouter]
changed: [centralServer]
changed: [office1Router]
changed: [office1Server]
changed: [office2Router]
changed: [centralRouter]
changed: [testClient1]
changed: [office2Server]
changed: [testClient2]
changed: [testServer2]
changed: [testServer1]

TASK [../roles/routing : /etc/sysconfig/network-scripts/ifcfg-ethX | GATEWAY=<ip> | replace] ***
skipping: [inetRouter]
skipping: [centralRouter]
skipping: [centralServer]
skipping: [office1Router]
skipping: [office1Server]
skipping: [office2Router]
skipping: [office2Server]
skipping: [testServer1]
skipping: [testServer2]
skipping: [testClient1]
skipping: [testClient2]

TASK [../roles/routing : /etc/sysconfig/network-scripts/ifcfg-eth0 | content] ***
changed: [office1Router]
changed: [inetRouter]
changed: [centralRouter]
changed: [office1Server]
changed: [centralServer]
changed: [testServer2]
changed: [office2Server]
changed: [office2Router]
changed: [testClient1]
changed: [testServer1]
changed: [testClient2]

TASK [../roles/routing : /etc/sysconfig/network-scripts/ifcfg-eth0 | DEFROUTE=no | if did not set] ***
changed: [inetRouter]
changed: [centralRouter]
changed: [centralServer]
changed: [office1Server]
changed: [office1Router]
changed: [office2Router]
changed: [testServer1]
changed: [office2Server]
changed: [testServer2]
changed: [testClient1]
changed: [testClient2]

TASK [../roles/routing : /etc/sysconfig/network-scripts/ifcfg-eth0 | DEFROUTE=no | if "yes"] ***
ok: [centralRouter]
ok: [office1Server]
ok: [inetRouter]
ok: [centralServer]
ok: [office1Router]
ok: [office2Router]
ok: [office2Server]
ok: [testServer1]
ok: [testServer2]
ok: [testClient1]
ok: [testClient2]

TASK [../roles/routing : /etc/sysconfig/network-scripts/ifcfg-ethX | content] ***
changed: [centralServer]
changed: [office1Router]
changed: [inetRouter]
changed: [centralRouter]
changed: [office1Server]
changed: [office2Router]
changed: [testServer1]
changed: [office2Server]
changed: [testServer2]
changed: [testClient1]
changed: [testClient2]

TASK [../roles/routing : /etc/sysconfig/network-scripts/ifcfg-ethX | DEFROUTE=yes  | if did not set] ***
skipping: [inetRouter]
changed: [office1Router]
changed: [centralServer]
changed: [office2Router]
changed: [centralRouter]
changed: [office1Server]
changed: [testClient1]
changed: [testServer1]
changed: [office2Server]
changed: [testClient2]
changed: [testServer2]

TASK [../roles/routing : /etc/sysconfig/network-scripts/ifcfg-ethX | DEFROUTE=yes | if "no"] ***
skipping: [centralRouter]
skipping: [centralServer]
skipping: [office1Router]
skipping: [office1Server]
skipping: [office2Router]
skipping: [office2Server]
skipping: [testServer1]
skipping: [testServer2]
skipping: [testClient1]
skipping: [testClient2]
changed: [inetRouter]

TASK [../roles/routing : /etc/sysctl.conf | content] ***************************
changed: [inetRouter]
changed: [centralRouter]
changed: [centralServer]
changed: [office1Router]
changed: [office1Server]
changed: [office2Router]
changed: [office2Server]
changed: [testServer1]
changed: [testServer2]
changed: [testClient1]
changed: [testClient2]

TASK [../roles/routing : /etc/sysctl.conf | forwarding set up | if does not yet] ***
skipping: [centralServer]
changed: [office2Router]
changed: [centralRouter]
changed: [office1Router]
changed: [inetRouter]
skipping: [office2Server]
skipping: [testServer1]
skipping: [testClient1]
skipping: [testServer2]
skipping: [testClient2]
changed: [office1Server]

TASK [../roles/routing : /etc/sysctl.conf | forwarding set up | if it was early] ***
skipping: [inetRouter]
skipping: [centralRouter]
skipping: [centralServer]
skipping: [office1Router]
skipping: [office1Server]
skipping: [office2Router]
skipping: [office2Server]
skipping: [testServer1]
skipping: [testServer2]
skipping: [testClient1]
skipping: [testClient2]

TASK [../roles/routing : /etc/sysctl.conf | ip_forward set up | if does not yet] ***
skipping: [inetRouter]
skipping: [centralRouter]
skipping: [centralServer]
skipping: [office1Router]
skipping: [office1Server]
skipping: [office2Router]
skipping: [office2Server]
skipping: [testServer1]
skipping: [testServer2]
skipping: [testClient1]
skipping: [testClient2]

TASK [../roles/routing : /etc/sysctl.conf | ip_forward set up | if it was early] ***
skipping: [inetRouter]
skipping: [centralRouter]
skipping: [centralServer]
skipping: [office2Router]
skipping: [office1Router]
skipping: [office1Server]
skipping: [testServer1]
skipping: [office2Server]
skipping: [testServer2]
skipping: [testClient1]
skipping: [testClient2]

RUNNING HANDLER [../roles/routing : systemctl-restart-network] *****************
changed: [office1Server]
changed: [inetRouter]
changed: [centralServer]
changed: [centralRouter]
changed: [testClient1]
changed: [office2Server]
changed: [office2Router]
changed: [office1Router]
changed: [testServer2]
changed: [testClient2]
changed: [testServer1]

PLAY RECAP *********************************************************************
centralRouter              : ok=15   changed=13   unreachable=0    failed=0    skipped=5    rescued=0    ignored=0   
centralServer              : ok=12   changed=10   unreachable=0    failed=0    skipped=8    rescued=0    ignored=0   
inetRouter                 : ok=14   changed=12   unreachable=0    failed=0    skipped=6    rescued=0    ignored=0   
office1Router              : ok=13   changed=11   unreachable=0    failed=0    skipped=7    rescued=0    ignored=0   
office1Server              : ok=13   changed=11   unreachable=0    failed=0    skipped=7    rescued=0    ignored=0   
office2Router              : ok=13   changed=11   unreachable=0    failed=0    skipped=7    rescued=0    ignored=0   
office2Server              : ok=12   changed=10   unreachable=0    failed=0    skipped=8    rescued=0    ignored=0   
testClient1                : ok=12   changed=10   unreachable=0    failed=0    skipped=8    rescued=0    ignored=0   
testClient2                : ok=12   changed=10   unreachable=0    failed=0    skipped=8    rescued=0    ignored=0   
testServer1                : ok=12   changed=10   unreachable=0    failed=0    skipped=8    rescued=0    ignored=0   
testServer2                : ok=12   changed=10   unreachable=0    failed=0    skipped=8    rescued=0    ignored=0   


```

</details>


<details><summary>см. playbooks/internet-router.yml</summary>

```text

PLAY [Playbook of internet-node server initialization] *************************

TASK [Gathering Facts] *********************************************************
ok: [inetRouter]

TASK [../roles/internet-router : iptables masquerading] ************************
changed: [inetRouter]

PLAY RECAP *********************************************************************
inetRouter                 : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   


```

</details>


<details><summary>см. playbooks/test_network_connectivity.yml</summary>

```text

PLAY [Playbook of tests] *******************************************************

TASK [Gathering Facts] *********************************************************
ok: [office1Server]
ok: [centralServer]
ok: [inetRouter]
ok: [centralRouter]
ok: [office1Router]
ok: [office2Server]
ok: [office2Router]
ok: [testServer2]
ok: [testClient1]
ok: [testServer1]
ok: [testClient2]

TASK [../roles/test_network_connectivity : test | install traceroute] **********
ok: [office1Router]
ok: [office1Server]
ok: [centralRouter]
ok: [centralServer]
ok: [inetRouter]
ok: [office2Server]
ok: [office2Router]
ok: [testClient1]
ok: [testServer1]
ok: [testServer2]
ok: [testClient2]

TASK [../roles/test_network_connectivity : test | traceroute foreign host] *****
changed: [inetRouter] => (item=8.8.8.8)
changed: [centralRouter] => (item=8.8.8.8)
changed: [centralServer] => (item=8.8.8.8)
changed: [office1Router] => (item=8.8.8.8)
changed: [office1Server] => (item=8.8.8.8)
changed: [office2Router] => (item=8.8.8.8)
changed: [testServer1] => (item=8.8.8.8)
changed: [office2Server] => (item=8.8.8.8)
changed: [testServer2] => (item=8.8.8.8)
changed: [testClient1] => (item=8.8.8.8)
changed: [testClient2] => (item=8.8.8.8)

TASK [../roles/test_network_connectivity : test | result file output] **********
changed: [centralRouter -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:44:58.113537', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.255.1)  0.350 ms  0.242 ms  0.300 ms\n 2  * * *\n 3  * * *\n 4  * * *\n 5  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  13.778 ms  13.525 ms  13.298 ms\n 6  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  22.106 ms  13.160 ms 212.48.194.212 (212.48.194.212)  13.102 ms\n 7  188.254.2.6 (188.254.2.6)  39.954 ms  41.827 ms 188.254.2.4 (188.254.2.4)  34.916 ms\n 8  87.226.194.47 (87.226.194.47)  36.409 ms  36.708 ms  37.825 ms\n 9  74.125.244.180 (74.125.244.180)  29.243 ms 74.125.244.132 (74.125.244.132)  23.541 ms  38.770 ms\n10  72.14.232.85 (72.14.232.85)  35.928 ms 216.239.48.163 (216.239.48.163)  37.993 ms 142.251.61.219 (142.251.61.219)  37.192 ms\n11  142.251.61.221 (142.251.61.221)  60.420 ms  34.456 ms 142.251.51.187 (142.251.51.187)  46.276 ms\n12  216.239.54.201 (216.239.54.201)  38.905 ms 216.239.63.65 (216.239.63.65)  36.891 ms *\n13  * * *\n14  * * *\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  dns.google (8.8.8.8)  35.819 ms  36.911 ms *', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:42.102924', 'stderr': '', 'delta': '0:00:16.010613', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.255.1)  0.350 ms  0.242 ms  0.300 ms', ' 2  * * *', ' 3  * * *', ' 4  * * *', ' 5  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  13.778 ms  13.525 ms  13.298 ms', ' 6  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  22.106 ms  13.160 ms 212.48.194.212 (212.48.194.212)  13.102 ms', ' 7  188.254.2.6 (188.254.2.6)  39.954 ms  41.827 ms 188.254.2.4 (188.254.2.4)  34.916 ms', ' 8  87.226.194.47 (87.226.194.47)  36.409 ms  36.708 ms  37.825 ms', ' 9  74.125.244.180 (74.125.244.180)  29.243 ms 74.125.244.132 (74.125.244.132)  23.541 ms  38.770 ms', '10  72.14.232.85 (72.14.232.85)  35.928 ms 216.239.48.163 (216.239.48.163)  37.993 ms 142.251.61.219 (142.251.61.219)  37.192 ms', '11  142.251.61.221 (142.251.61.221)  60.420 ms  34.456 ms 142.251.51.187 (142.251.51.187)  46.276 ms', '12  216.239.54.201 (216.239.54.201)  38.905 ms 216.239.63.65 (216.239.63.65)  36.891 ms *', '13  * * *', '14  * * *', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  dns.google (8.8.8.8)  35.819 ms  36.911 ms *'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [office1Server -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:44:58.389297', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.2.193)  0.435 ms  0.479 ms  4.019 ms\n 2  192.168.0.33 (192.168.0.33)  6.004 ms  5.804 ms  5.626 ms\n 3  192.168.255.1 (192.168.255.1)  14.382 ms  14.232 ms  14.015 ms\n 4  * * *\n 5  * * *\n 6  * * *\n 7  * * *\n 8  212.48.194.212 (212.48.194.212)  20.940 ms  24.038 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  23.887 ms\n 9  188.254.2.6 (188.254.2.6)  37.753 ms 188.254.2.4 (188.254.2.4)  42.181 ms 188.254.2.6 (188.254.2.6)  38.467 ms\n10  87.226.194.47 (87.226.194.47)  39.091 ms  31.687 ms  44.064 ms\n11  74.125.244.180 (74.125.244.180)  34.177 ms 74.125.244.132 (74.125.244.132)  42.700 ms 74.125.244.180 (74.125.244.180)  37.810 ms\n12  216.239.48.163 (216.239.48.163)  40.886 ms  40.507 ms 72.14.232.85 (72.14.232.85)  40.018 ms\n13  142.250.233.27 (142.250.233.27)  39.559 ms 142.250.208.23 (142.250.208.23)  56.343 ms 209.85.246.111 (209.85.246.111)  48.645 ms\n14  142.250.56.217 (142.250.56.217)  48.495 ms 216.239.57.5 (216.239.57.5)  48.353 ms *\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  * * *\n22  * * *\n23  dns.google (8.8.8.8)  45.760 ms * *', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:42.038020', 'stderr': '', 'delta': '0:00:16.351277', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.2.193)  0.435 ms  0.479 ms  4.019 ms', ' 2  192.168.0.33 (192.168.0.33)  6.004 ms  5.804 ms  5.626 ms', ' 3  192.168.255.1 (192.168.255.1)  14.382 ms  14.232 ms  14.015 ms', ' 4  * * *', ' 5  * * *', ' 6  * * *', ' 7  * * *', ' 8  212.48.194.212 (212.48.194.212)  20.940 ms  24.038 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  23.887 ms', ' 9  188.254.2.6 (188.254.2.6)  37.753 ms 188.254.2.4 (188.254.2.4)  42.181 ms 188.254.2.6 (188.254.2.6)  38.467 ms', '10  87.226.194.47 (87.226.194.47)  39.091 ms  31.687 ms  44.064 ms', '11  74.125.244.180 (74.125.244.180)  34.177 ms 74.125.244.132 (74.125.244.132)  42.700 ms 74.125.244.180 (74.125.244.180)  37.810 ms', '12  216.239.48.163 (216.239.48.163)  40.886 ms  40.507 ms 72.14.232.85 (72.14.232.85)  40.018 ms', '13  142.250.233.27 (142.250.233.27)  39.559 ms 142.250.208.23 (142.250.208.23)  56.343 ms 209.85.246.111 (209.85.246.111)  48.645 ms', '14  142.250.56.217 (142.250.56.217)  48.495 ms 216.239.57.5 (216.239.57.5)  48.353 ms *', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  * * *', '22  * * *', '23  dns.google (8.8.8.8)  45.760 ms * *'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [centralServer -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:44:58.167234', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.0.1)  0.496 ms  0.239 ms  0.307 ms\n 2  192.168.255.1 (192.168.255.1)  6.442 ms  6.241 ms  6.395 ms\n 3  * * *\n 4  * * *\n 5  * * *\n 6  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  11.496 ms  10.359 ms  17.820 ms\n 7  212.48.194.212 (212.48.194.212)  18.821 ms  13.393 ms  15.142 ms\n 8  188.254.2.6 (188.254.2.6)  35.730 ms 188.254.2.4 (188.254.2.4)  35.594 ms  35.397 ms\n 9  87.226.194.47 (87.226.194.47)  52.928 ms  52.816 ms  40.230 ms\n10  74.125.244.180 (74.125.244.180)  38.228 ms 74.125.244.132 (74.125.244.132)  33.673 ms  46.706 ms\n11  142.251.61.219 (142.251.61.219)  42.094 ms  33.875 ms 216.239.48.163 (216.239.48.163)  58.363 ms\n12  142.251.51.187 (142.251.51.187)  33.523 ms  33.404 ms 216.239.58.53 (216.239.58.53)  37.688 ms\n13  * 142.250.209.171 (142.250.209.171)  44.028 ms *\n14  * * *\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  * * *\n22  * dns.google (8.8.8.8)  52.014 ms *', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:41.867331', 'stderr': '', 'delta': '0:00:16.299903', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.0.1)  0.496 ms  0.239 ms  0.307 ms', ' 2  192.168.255.1 (192.168.255.1)  6.442 ms  6.241 ms  6.395 ms', ' 3  * * *', ' 4  * * *', ' 5  * * *', ' 6  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  11.496 ms  10.359 ms  17.820 ms', ' 7  212.48.194.212 (212.48.194.212)  18.821 ms  13.393 ms  15.142 ms', ' 8  188.254.2.6 (188.254.2.6)  35.730 ms 188.254.2.4 (188.254.2.4)  35.594 ms  35.397 ms', ' 9  87.226.194.47 (87.226.194.47)  52.928 ms  52.816 ms  40.230 ms', '10  74.125.244.180 (74.125.244.180)  38.228 ms 74.125.244.132 (74.125.244.132)  33.673 ms  46.706 ms', '11  142.251.61.219 (142.251.61.219)  42.094 ms  33.875 ms 216.239.48.163 (216.239.48.163)  58.363 ms', '12  142.251.51.187 (142.251.51.187)  33.523 ms  33.404 ms 216.239.58.53 (216.239.58.53)  37.688 ms', '13  * 142.250.209.171 (142.250.209.171)  44.028 ms *', '14  * * *', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  * * *', '22  * dns.google (8.8.8.8)  52.014 ms *'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [office1Router -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:44:58.234188', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.0.33)  1.253 ms  1.063 ms  1.186 ms\n 2  192.168.255.1 (192.168.255.1)  5.215 ms  5.159 ms  5.268 ms\n 3  * * *\n 4  * * *\n 5  * * *\n 6  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  16.892 ms  32.552 ms  32.004 ms\n 7  212.48.194.212 (212.48.194.212)  33.068 ms  21.481 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  27.478 ms\n 8  188.254.2.4 (188.254.2.4)  33.421 ms  40.776 ms 188.254.2.6 (188.254.2.6)  35.940 ms\n 9  87.226.194.47 (87.226.194.47)  40.329 ms  40.016 ms  30.921 ms\n10  74.125.244.180 (74.125.244.180)  49.964 ms 74.125.244.132 (74.125.244.132)  44.561 ms  40.944 ms\n11  72.14.232.85 (72.14.232.85)  37.267 ms  36.917 ms 142.251.61.219 (142.251.61.219)  44.391 ms\n12  216.239.49.113 (216.239.49.113)  58.956 ms 142.250.208.23 (142.250.208.23)  37.592 ms 142.251.51.187 (142.251.51.187)  44.728 ms\n13  * 72.14.237.201 (72.14.237.201)  43.965 ms 172.253.51.249 (172.253.51.249)  43.643 ms\n14  * * *\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  * * *\n22  * * *\n23  dns.google (8.8.8.8)  42.932 ms  44.078 ms *', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:42.204184', 'stderr': '', 'delta': '0:00:16.030004', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.0.33)  1.253 ms  1.063 ms  1.186 ms', ' 2  192.168.255.1 (192.168.255.1)  5.215 ms  5.159 ms  5.268 ms', ' 3  * * *', ' 4  * * *', ' 5  * * *', ' 6  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  16.892 ms  32.552 ms  32.004 ms', ' 7  212.48.194.212 (212.48.194.212)  33.068 ms  21.481 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  27.478 ms', ' 8  188.254.2.4 (188.254.2.4)  33.421 ms  40.776 ms 188.254.2.6 (188.254.2.6)  35.940 ms', ' 9  87.226.194.47 (87.226.194.47)  40.329 ms  40.016 ms  30.921 ms', '10  74.125.244.180 (74.125.244.180)  49.964 ms 74.125.244.132 (74.125.244.132)  44.561 ms  40.944 ms', '11  72.14.232.85 (72.14.232.85)  37.267 ms  36.917 ms 142.251.61.219 (142.251.61.219)  44.391 ms', '12  216.239.49.113 (216.239.49.113)  58.956 ms 142.250.208.23 (142.250.208.23)  37.592 ms 142.251.51.187 (142.251.51.187)  44.728 ms', '13  * 72.14.237.201 (72.14.237.201)  43.965 ms 172.253.51.249 (172.253.51.249)  43.643 ms', '14  * * *', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  * * *', '22  * * *', '23  dns.google (8.8.8.8)  42.932 ms  44.078 ms *'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [inetRouter -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:44:52.803944', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (10.0.2.2)  5.289 ms  5.058 ms  4.481 ms\n 2  * * *\n 3  * * *\n 4  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  12.562 ms  24.379 ms  24.432 ms\n 5  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  24.524 ms 212.48.194.212 (212.48.194.212)  24.609 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  28.671 ms\n 6  188.254.2.4 (188.254.2.4)  33.531 ms 188.254.2.6 (188.254.2.6)  29.627 ms  30.288 ms\n 7  87.226.194.47 (87.226.194.47)  36.355 ms  35.816 ms  36.748 ms\n 8  74.125.244.132 (74.125.244.132)  53.706 ms 74.125.244.180 (74.125.244.180)  55.330 ms  55.168 ms\n 9  216.239.48.163 (216.239.48.163)  54.996 ms 72.14.232.85 (72.14.232.85)  54.847 ms 142.251.61.219 (142.251.61.219)  38.585 ms\n10  142.251.61.221 (142.251.61.221)  41.049 ms  42.024 ms 142.251.51.187 (142.251.51.187)  47.723 ms\n11  * * 216.239.63.25 (216.239.63.25)  38.257 ms\n12  * * *\n13  * * *\n14  * * *\n15  * * *\n16  * * *\n17  * * *\n18  * * dns.google (8.8.8.8)  44.000 ms', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:42.283152', 'stderr': '', 'delta': '0:00:10.520792', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (10.0.2.2)  5.289 ms  5.058 ms  4.481 ms', ' 2  * * *', ' 3  * * *', ' 4  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  12.562 ms  24.379 ms  24.432 ms', ' 5  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  24.524 ms 212.48.194.212 (212.48.194.212)  24.609 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  28.671 ms', ' 6  188.254.2.4 (188.254.2.4)  33.531 ms 188.254.2.6 (188.254.2.6)  29.627 ms  30.288 ms', ' 7  87.226.194.47 (87.226.194.47)  36.355 ms  35.816 ms  36.748 ms', ' 8  74.125.244.132 (74.125.244.132)  53.706 ms 74.125.244.180 (74.125.244.180)  55.330 ms  55.168 ms', ' 9  216.239.48.163 (216.239.48.163)  54.996 ms 72.14.232.85 (72.14.232.85)  54.847 ms 142.251.61.219 (142.251.61.219)  38.585 ms', '10  142.251.61.221 (142.251.61.221)  41.049 ms  42.024 ms 142.251.51.187 (142.251.51.187)  47.723 ms', '11  * * 216.239.63.25 (216.239.63.25)  38.257 ms', '12  * * *', '13  * * *', '14  * * *', '15  * * *', '16  * * *', '17  * * *', '18  * * dns.google (8.8.8.8)  44.000 ms'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [office2Router -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:45:09.698785', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.0.33)  0.398 ms  0.165 ms  0.219 ms\n 2  192.168.255.1 (192.168.255.1)  11.663 ms  11.412 ms  11.234 ms\n 3  * * *\n 4  * * *\n 5  * * *\n 6  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  13.415 ms  18.061 ms  17.653 ms\n 7  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  12.422 ms 212.48.194.212 (212.48.194.212)  18.972 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  21.756 ms\n 8  188.254.2.6 (188.254.2.6)  43.047 ms 188.254.2.4 (188.254.2.4)  34.500 ms  33.248 ms\n 9  87.226.194.47 (87.226.194.47)  44.739 ms  36.638 ms  30.139 ms\n10  74.125.244.180 (74.125.244.180)  42.475 ms 74.125.244.132 (74.125.244.132)  24.193 ms  29.116 ms\n11  142.251.61.219 (142.251.61.219)  32.608 ms 216.239.48.163 (216.239.48.163)  31.958 ms  31.693 ms\n12  142.251.61.221 (142.251.61.221)  30.900 ms  34.501 ms 142.250.56.125 (142.250.56.125)  45.582 ms\n13  * 209.85.254.179 (209.85.254.179)  29.633 ms 216.239.47.173 (216.239.47.173)  39.541 ms\n14  * * *\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  * * *\n22  * dns.google (8.8.8.8)  39.513 ms  40.180 ms', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:53.844158', 'stderr': '', 'delta': '0:00:15.854627', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.0.33)  0.398 ms  0.165 ms  0.219 ms', ' 2  192.168.255.1 (192.168.255.1)  11.663 ms  11.412 ms  11.234 ms', ' 3  * * *', ' 4  * * *', ' 5  * * *', ' 6  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  13.415 ms  18.061 ms  17.653 ms', ' 7  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  12.422 ms 212.48.194.212 (212.48.194.212)  18.972 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  21.756 ms', ' 8  188.254.2.6 (188.254.2.6)  43.047 ms 188.254.2.4 (188.254.2.4)  34.500 ms  33.248 ms', ' 9  87.226.194.47 (87.226.194.47)  44.739 ms  36.638 ms  30.139 ms', '10  74.125.244.180 (74.125.244.180)  42.475 ms 74.125.244.132 (74.125.244.132)  24.193 ms  29.116 ms', '11  142.251.61.219 (142.251.61.219)  32.608 ms 216.239.48.163 (216.239.48.163)  31.958 ms  31.693 ms', '12  142.251.61.221 (142.251.61.221)  30.900 ms  34.501 ms 142.250.56.125 (142.250.56.125)  45.582 ms', '13  * 209.85.254.179 (209.85.254.179)  29.633 ms 216.239.47.173 (216.239.47.173)  39.541 ms', '14  * * *', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  * * *', '22  * dns.google (8.8.8.8)  39.513 ms  40.180 ms'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [testServer1 -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:45:15.404449', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.2.65)  0.826 ms  0.460 ms  0.834 ms\n 2  192.168.0.33 (192.168.0.33)  1.738 ms  1.310 ms  0.816 ms\n 3  192.168.255.1 (192.168.255.1)  1.486 ms  3.828 ms  4.449 ms\n 4  * * *\n 5  * * *\n 6  * * *\n 7  * * *\n 8  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  31.013 ms  29.406 ms 212.48.194.212 (212.48.194.212)  33.643 ms\n 9  188.254.2.6 (188.254.2.6)  45.548 ms 188.254.2.4 (188.254.2.4)  30.602 ms 188.254.2.6 (188.254.2.6)  39.138 ms\n10  87.226.194.47 (87.226.194.47)  30.976 ms  32.271 ms  29.862 ms\n11  74.125.244.132 (74.125.244.132)  36.426 ms 74.125.244.180 (74.125.244.180)  30.541 ms 74.125.244.132 (74.125.244.132)  26.141 ms\n12  142.251.61.219 (142.251.61.219)  32.886 ms  34.510 ms  34.152 ms\n13  142.251.51.187 (142.251.51.187)  52.318 ms 142.250.210.45 (142.250.210.45)  39.675 ms 142.251.61.221 (142.251.61.221)  44.911 ms\n14  72.14.236.73 (72.14.236.73)  47.896 ms * 172.253.79.115 (172.253.79.115)  39.785 ms\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  * * *\n22  * * *\n23  * * *\n24  dns.google (8.8.8.8)  54.887 ms  61.805 ms  55.062 ms', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:59.433713', 'stderr': '', 'delta': '0:00:15.970736', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.2.65)  0.826 ms  0.460 ms  0.834 ms', ' 2  192.168.0.33 (192.168.0.33)  1.738 ms  1.310 ms  0.816 ms', ' 3  192.168.255.1 (192.168.255.1)  1.486 ms  3.828 ms  4.449 ms', ' 4  * * *', ' 5  * * *', ' 6  * * *', ' 7  * * *', ' 8  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  31.013 ms  29.406 ms 212.48.194.212 (212.48.194.212)  33.643 ms', ' 9  188.254.2.6 (188.254.2.6)  45.548 ms 188.254.2.4 (188.254.2.4)  30.602 ms 188.254.2.6 (188.254.2.6)  39.138 ms', '10  87.226.194.47 (87.226.194.47)  30.976 ms  32.271 ms  29.862 ms', '11  74.125.244.132 (74.125.244.132)  36.426 ms 74.125.244.180 (74.125.244.180)  30.541 ms 74.125.244.132 (74.125.244.132)  26.141 ms', '12  142.251.61.219 (142.251.61.219)  32.886 ms  34.510 ms  34.152 ms', '13  142.251.51.187 (142.251.51.187)  52.318 ms 142.250.210.45 (142.250.210.45)  39.675 ms 142.251.61.221 (142.251.61.221)  44.911 ms', '14  72.14.236.73 (72.14.236.73)  47.896 ms * 172.253.79.115 (172.253.79.115)  39.785 ms', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  * * *', '22  * * *', '23  * * *', '24  dns.google (8.8.8.8)  54.887 ms  61.805 ms  55.062 ms'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [office2Server -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:45:15.591475', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.1.193)  0.938 ms  0.600 ms  0.359 ms\n 2  192.168.0.33 (192.168.0.33)  0.943 ms  2.009 ms  1.705 ms\n 3  192.168.255.1 (192.168.255.1)  1.999 ms  1.731 ms  1.474 ms\n 4  * * *\n 5  * * *\n 6  * * *\n 7  * * *\n 8  212.48.194.212 (212.48.194.212)  30.486 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  30.932 ms 212.48.194.212 (212.48.194.212)  37.691 ms\n 9  188.254.2.6 (188.254.2.6)  58.619 ms  38.859 ms  38.335 ms\n10  87.226.194.47 (87.226.194.47)  50.109 ms  28.947 ms  31.173 ms\n11  74.125.244.180 (74.125.244.180)  32.061 ms 74.125.244.132 (74.125.244.132)  27.923 ms 74.125.244.180 (74.125.244.180)  35.241 ms\n12  72.14.232.85 (72.14.232.85)  33.872 ms 216.239.48.163 (216.239.48.163)  34.933 ms 72.14.232.85 (72.14.232.85)  35.209 ms\n13  142.251.51.187 (142.251.51.187)  38.743 ms 172.253.51.239 (172.253.51.239)  59.866 ms 142.251.61.221 (142.251.61.221)  56.157 ms\n14  142.250.209.161 (142.250.209.161)  45.083 ms * 142.250.56.221 (142.250.56.221)  31.440 ms\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  * * *\n22  * * *\n23  dns.google (8.8.8.8)  55.651 ms *  55.315 ms', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:59.384446', 'stderr': '', 'delta': '0:00:16.207029', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.1.193)  0.938 ms  0.600 ms  0.359 ms', ' 2  192.168.0.33 (192.168.0.33)  0.943 ms  2.009 ms  1.705 ms', ' 3  192.168.255.1 (192.168.255.1)  1.999 ms  1.731 ms  1.474 ms', ' 4  * * *', ' 5  * * *', ' 6  * * *', ' 7  * * *', ' 8  212.48.194.212 (212.48.194.212)  30.486 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  30.932 ms 212.48.194.212 (212.48.194.212)  37.691 ms', ' 9  188.254.2.6 (188.254.2.6)  58.619 ms  38.859 ms  38.335 ms', '10  87.226.194.47 (87.226.194.47)  50.109 ms  28.947 ms  31.173 ms', '11  74.125.244.180 (74.125.244.180)  32.061 ms 74.125.244.132 (74.125.244.132)  27.923 ms 74.125.244.180 (74.125.244.180)  35.241 ms', '12  72.14.232.85 (72.14.232.85)  33.872 ms 216.239.48.163 (216.239.48.163)  34.933 ms 72.14.232.85 (72.14.232.85)  35.209 ms', '13  142.251.51.187 (142.251.51.187)  38.743 ms 172.253.51.239 (172.253.51.239)  59.866 ms 142.251.61.221 (142.251.61.221)  56.157 ms', '14  142.250.209.161 (142.250.209.161)  45.083 ms * 142.250.56.221 (142.250.56.221)  31.440 ms', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  * * *', '22  * * *', '23  dns.google (8.8.8.8)  55.651 ms *  55.315 ms'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [testServer2 -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:45:15.556384', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.2.65)  0.685 ms  0.449 ms  0.395 ms\n 2  192.168.0.33 (192.168.0.33)  1.176 ms  0.662 ms  1.505 ms\n 3  192.168.255.1 (192.168.255.1)  2.767 ms  2.603 ms  2.416 ms\n 4  * * *\n 5  * * *\n 6  * * *\n 7  * * *\n 8  212.48.194.212 (212.48.194.212)  28.216 ms  30.936 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  30.782 ms\n 9  188.254.2.6 (188.254.2.6)  51.563 ms 188.254.2.4 (188.254.2.4)  29.908 ms  29.270 ms\n10  87.226.194.47 (87.226.194.47)  38.504 ms  25.635 ms  30.619 ms\n11  74.125.244.180 (74.125.244.180)  29.865 ms  24.351 ms  43.346 ms\n12  72.14.232.85 (72.14.232.85)  44.626 ms 142.251.61.219 (142.251.61.219)  44.637 ms  50.213 ms\n13  142.251.51.187 (142.251.51.187)  42.620 ms 172.253.79.113 (172.253.79.113)  36.546 ms 142.250.210.45 (142.250.210.45)  31.032 ms\n14  216.239.47.173 (216.239.47.173)  33.496 ms * 172.253.51.237 (172.253.51.237)  31.673 ms\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  * * *\n22  * * *\n23  dns.google (8.8.8.8)  48.648 ms * *', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:59.567700', 'stderr': '', 'delta': '0:00:15.988684', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.2.65)  0.685 ms  0.449 ms  0.395 ms', ' 2  192.168.0.33 (192.168.0.33)  1.176 ms  0.662 ms  1.505 ms', ' 3  192.168.255.1 (192.168.255.1)  2.767 ms  2.603 ms  2.416 ms', ' 4  * * *', ' 5  * * *', ' 6  * * *', ' 7  * * *', ' 8  212.48.194.212 (212.48.194.212)  28.216 ms  30.936 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  30.782 ms', ' 9  188.254.2.6 (188.254.2.6)  51.563 ms 188.254.2.4 (188.254.2.4)  29.908 ms  29.270 ms', '10  87.226.194.47 (87.226.194.47)  38.504 ms  25.635 ms  30.619 ms', '11  74.125.244.180 (74.125.244.180)  29.865 ms  24.351 ms  43.346 ms', '12  72.14.232.85 (72.14.232.85)  44.626 ms 142.251.61.219 (142.251.61.219)  44.637 ms  50.213 ms', '13  142.251.51.187 (142.251.51.187)  42.620 ms 172.253.79.113 (172.253.79.113)  36.546 ms 142.250.210.45 (142.250.210.45)  31.032 ms', '14  216.239.47.173 (216.239.47.173)  33.496 ms * 172.253.51.237 (172.253.51.237)  31.673 ms', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  * * *', '22  * * *', '23  dns.google (8.8.8.8)  48.648 ms * *'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [testClient1 -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:45:15.690617', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.2.65)  0.544 ms  2.712 ms  2.578 ms\n 2  192.168.0.33 (192.168.0.33)  2.942 ms  2.808 ms  2.980 ms\n 3  192.168.255.1 (192.168.255.1)  5.304 ms  5.124 ms  4.983 ms\n 4  * * *\n 5  * * *\n 6  * * *\n 7  * * *\n 8  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  32.995 ms  31.491 ms  35.760 ms\n 9  188.254.2.6 (188.254.2.6)  44.100 ms  35.062 ms  30.896 ms\n10  87.226.194.47 (87.226.194.47)  30.668 ms  27.026 ms  27.634 ms\n11  74.125.244.180 (74.125.244.180)  26.464 ms 74.125.244.132 (74.125.244.132)  37.853 ms  30.305 ms\n12  216.239.48.163 (216.239.48.163)  30.617 ms 72.14.232.85 (72.14.232.85)  28.295 ms  28.763 ms\n13  209.85.254.135 (209.85.254.135)  32.913 ms 216.239.47.167 (216.239.47.167)  29.363 ms 142.251.51.187 (142.251.51.187)  39.842 ms\n14  72.14.236.73 (72.14.236.73)  31.269 ms * *\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  * * *\n22  * * *\n23  * dns.google (8.8.8.8)  61.928 ms  57.540 ms', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:59.581891', 'stderr': '', 'delta': '0:00:16.108726', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.2.65)  0.544 ms  2.712 ms  2.578 ms', ' 2  192.168.0.33 (192.168.0.33)  2.942 ms  2.808 ms  2.980 ms', ' 3  192.168.255.1 (192.168.255.1)  5.304 ms  5.124 ms  4.983 ms', ' 4  * * *', ' 5  * * *', ' 6  * * *', ' 7  * * *', ' 8  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  32.995 ms  31.491 ms  35.760 ms', ' 9  188.254.2.6 (188.254.2.6)  44.100 ms  35.062 ms  30.896 ms', '10  87.226.194.47 (87.226.194.47)  30.668 ms  27.026 ms  27.634 ms', '11  74.125.244.180 (74.125.244.180)  26.464 ms 74.125.244.132 (74.125.244.132)  37.853 ms  30.305 ms', '12  216.239.48.163 (216.239.48.163)  30.617 ms 72.14.232.85 (72.14.232.85)  28.295 ms  28.763 ms', '13  209.85.254.135 (209.85.254.135)  32.913 ms 216.239.47.167 (216.239.47.167)  29.363 ms 142.251.51.187 (142.251.51.187)  39.842 ms', '14  72.14.236.73 (72.14.236.73)  31.269 ms * *', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  * * *', '22  * * *', '23  * dns.google (8.8.8.8)  61.928 ms  57.540 ms'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [testClient2 -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:45:26.905327', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.2.65)  2.857 ms  2.637 ms  2.486 ms\n 2  192.168.0.33 (192.168.0.33)  5.097 ms  4.916 ms  4.753 ms\n 3  192.168.255.1 (192.168.255.1)  4.858 ms  5.898 ms  5.756 ms\n 4  * * *\n 5  * * *\n 6  * * *\n 7  * * *\n 8  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  24.668 ms 212.48.194.212 (212.48.194.212)  25.332 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  25.189 ms\n 9  188.254.2.4 (188.254.2.4)  75.665 ms 188.254.2.6 (188.254.2.6)  71.644 ms  73.809 ms\n10  87.226.194.47 (87.226.194.47)  73.659 ms  36.438 ms  28.578 ms\n11  74.125.244.132 (74.125.244.132)  49.853 ms  29.913 ms  36.673 ms\n12  72.14.232.85 (72.14.232.85)  26.814 ms 142.251.61.219 (142.251.61.219)  32.171 ms 72.14.232.85 (72.14.232.85)  29.363 ms\n13  172.253.64.113 (172.253.64.113)  40.648 ms 142.251.61.221 (142.251.61.221)  37.388 ms 72.14.237.199 (72.14.237.199)  47.688 ms\n14  * 72.14.237.201 (72.14.237.201)  33.024 ms 216.239.40.61 (216.239.40.61)  36.936 ms\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  * * *\n22  * * *\n23  * dns.google (8.8.8.8)  40.873 ms  42.584 ms', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:45:10.436649', 'stderr': '', 'delta': '0:00:16.468678', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.2.65)  2.857 ms  2.637 ms  2.486 ms', ' 2  192.168.0.33 (192.168.0.33)  5.097 ms  4.916 ms  4.753 ms', ' 3  192.168.255.1 (192.168.255.1)  4.858 ms  5.898 ms  5.756 ms', ' 4  * * *', ' 5  * * *', ' 6  * * *', ' 7  * * *', ' 8  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  24.668 ms 212.48.194.212 (212.48.194.212)  25.332 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  25.189 ms', ' 9  188.254.2.4 (188.254.2.4)  75.665 ms 188.254.2.6 (188.254.2.6)  71.644 ms  73.809 ms', '10  87.226.194.47 (87.226.194.47)  73.659 ms  36.438 ms  28.578 ms', '11  74.125.244.132 (74.125.244.132)  49.853 ms  29.913 ms  36.673 ms', '12  72.14.232.85 (72.14.232.85)  26.814 ms 142.251.61.219 (142.251.61.219)  32.171 ms 72.14.232.85 (72.14.232.85)  29.363 ms', '13  172.253.64.113 (172.253.64.113)  40.648 ms 142.251.61.221 (142.251.61.221)  37.388 ms 72.14.237.199 (72.14.237.199)  47.688 ms', '14  * 72.14.237.201 (72.14.237.201)  33.024 ms 216.239.40.61 (216.239.40.61)  36.936 ms', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  * * *', '22  * * *', '23  * dns.google (8.8.8.8)  40.873 ms  42.584 ms'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
centralRouter              : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
centralServer              : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
inetRouter                 : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
office1Router              : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
office1Server              : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
office2Router              : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
office2Server              : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
testClient1                : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
testClient2                : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
testServer1                : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
testServer2                : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   


```

</details>


<details><summary>см. playbooks/test_network_connectivity.yml</summary>

```text

PLAY [Playbook of tests] *******************************************************

TASK [Gathering Facts] *********************************************************
ok: [office1Server]
ok: [centralServer]
ok: [inetRouter]
ok: [centralRouter]
ok: [office1Router]
ok: [office2Server]
ok: [office2Router]
ok: [testServer2]
ok: [testClient1]
ok: [testServer1]
ok: [testClient2]

TASK [../roles/test_network_connectivity : test | install traceroute] **********
ok: [office1Router]
ok: [office1Server]
ok: [centralRouter]
ok: [centralServer]
ok: [inetRouter]
ok: [office2Server]
ok: [office2Router]
ok: [testClient1]
ok: [testServer1]
ok: [testServer2]
ok: [testClient2]

TASK [../roles/test_network_connectivity : test | traceroute foreign host] *****
changed: [inetRouter] => (item=8.8.8.8)
changed: [centralRouter] => (item=8.8.8.8)
changed: [centralServer] => (item=8.8.8.8)
changed: [office1Router] => (item=8.8.8.8)
changed: [office1Server] => (item=8.8.8.8)
changed: [office2Router] => (item=8.8.8.8)
changed: [testServer1] => (item=8.8.8.8)
changed: [office2Server] => (item=8.8.8.8)
changed: [testServer2] => (item=8.8.8.8)
changed: [testClient1] => (item=8.8.8.8)
changed: [testClient2] => (item=8.8.8.8)

TASK [../roles/test_network_connectivity : test | result file output] **********
changed: [centralRouter -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:44:58.113537', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.255.1)  0.350 ms  0.242 ms  0.300 ms\n 2  * * *\n 3  * * *\n 4  * * *\n 5  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  13.778 ms  13.525 ms  13.298 ms\n 6  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  22.106 ms  13.160 ms 212.48.194.212 (212.48.194.212)  13.102 ms\n 7  188.254.2.6 (188.254.2.6)  39.954 ms  41.827 ms 188.254.2.4 (188.254.2.4)  34.916 ms\n 8  87.226.194.47 (87.226.194.47)  36.409 ms  36.708 ms  37.825 ms\n 9  74.125.244.180 (74.125.244.180)  29.243 ms 74.125.244.132 (74.125.244.132)  23.541 ms  38.770 ms\n10  72.14.232.85 (72.14.232.85)  35.928 ms 216.239.48.163 (216.239.48.163)  37.993 ms 142.251.61.219 (142.251.61.219)  37.192 ms\n11  142.251.61.221 (142.251.61.221)  60.420 ms  34.456 ms 142.251.51.187 (142.251.51.187)  46.276 ms\n12  216.239.54.201 (216.239.54.201)  38.905 ms 216.239.63.65 (216.239.63.65)  36.891 ms *\n13  * * *\n14  * * *\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  dns.google (8.8.8.8)  35.819 ms  36.911 ms *', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:42.102924', 'stderr': '', 'delta': '0:00:16.010613', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.255.1)  0.350 ms  0.242 ms  0.300 ms', ' 2  * * *', ' 3  * * *', ' 4  * * *', ' 5  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  13.778 ms  13.525 ms  13.298 ms', ' 6  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  22.106 ms  13.160 ms 212.48.194.212 (212.48.194.212)  13.102 ms', ' 7  188.254.2.6 (188.254.2.6)  39.954 ms  41.827 ms 188.254.2.4 (188.254.2.4)  34.916 ms', ' 8  87.226.194.47 (87.226.194.47)  36.409 ms  36.708 ms  37.825 ms', ' 9  74.125.244.180 (74.125.244.180)  29.243 ms 74.125.244.132 (74.125.244.132)  23.541 ms  38.770 ms', '10  72.14.232.85 (72.14.232.85)  35.928 ms 216.239.48.163 (216.239.48.163)  37.993 ms 142.251.61.219 (142.251.61.219)  37.192 ms', '11  142.251.61.221 (142.251.61.221)  60.420 ms  34.456 ms 142.251.51.187 (142.251.51.187)  46.276 ms', '12  216.239.54.201 (216.239.54.201)  38.905 ms 216.239.63.65 (216.239.63.65)  36.891 ms *', '13  * * *', '14  * * *', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  dns.google (8.8.8.8)  35.819 ms  36.911 ms *'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [office1Server -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:44:58.389297', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.2.193)  0.435 ms  0.479 ms  4.019 ms\n 2  192.168.0.33 (192.168.0.33)  6.004 ms  5.804 ms  5.626 ms\n 3  192.168.255.1 (192.168.255.1)  14.382 ms  14.232 ms  14.015 ms\n 4  * * *\n 5  * * *\n 6  * * *\n 7  * * *\n 8  212.48.194.212 (212.48.194.212)  20.940 ms  24.038 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  23.887 ms\n 9  188.254.2.6 (188.254.2.6)  37.753 ms 188.254.2.4 (188.254.2.4)  42.181 ms 188.254.2.6 (188.254.2.6)  38.467 ms\n10  87.226.194.47 (87.226.194.47)  39.091 ms  31.687 ms  44.064 ms\n11  74.125.244.180 (74.125.244.180)  34.177 ms 74.125.244.132 (74.125.244.132)  42.700 ms 74.125.244.180 (74.125.244.180)  37.810 ms\n12  216.239.48.163 (216.239.48.163)  40.886 ms  40.507 ms 72.14.232.85 (72.14.232.85)  40.018 ms\n13  142.250.233.27 (142.250.233.27)  39.559 ms 142.250.208.23 (142.250.208.23)  56.343 ms 209.85.246.111 (209.85.246.111)  48.645 ms\n14  142.250.56.217 (142.250.56.217)  48.495 ms 216.239.57.5 (216.239.57.5)  48.353 ms *\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  * * *\n22  * * *\n23  dns.google (8.8.8.8)  45.760 ms * *', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:42.038020', 'stderr': '', 'delta': '0:00:16.351277', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.2.193)  0.435 ms  0.479 ms  4.019 ms', ' 2  192.168.0.33 (192.168.0.33)  6.004 ms  5.804 ms  5.626 ms', ' 3  192.168.255.1 (192.168.255.1)  14.382 ms  14.232 ms  14.015 ms', ' 4  * * *', ' 5  * * *', ' 6  * * *', ' 7  * * *', ' 8  212.48.194.212 (212.48.194.212)  20.940 ms  24.038 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  23.887 ms', ' 9  188.254.2.6 (188.254.2.6)  37.753 ms 188.254.2.4 (188.254.2.4)  42.181 ms 188.254.2.6 (188.254.2.6)  38.467 ms', '10  87.226.194.47 (87.226.194.47)  39.091 ms  31.687 ms  44.064 ms', '11  74.125.244.180 (74.125.244.180)  34.177 ms 74.125.244.132 (74.125.244.132)  42.700 ms 74.125.244.180 (74.125.244.180)  37.810 ms', '12  216.239.48.163 (216.239.48.163)  40.886 ms  40.507 ms 72.14.232.85 (72.14.232.85)  40.018 ms', '13  142.250.233.27 (142.250.233.27)  39.559 ms 142.250.208.23 (142.250.208.23)  56.343 ms 209.85.246.111 (209.85.246.111)  48.645 ms', '14  142.250.56.217 (142.250.56.217)  48.495 ms 216.239.57.5 (216.239.57.5)  48.353 ms *', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  * * *', '22  * * *', '23  dns.google (8.8.8.8)  45.760 ms * *'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [centralServer -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:44:58.167234', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.0.1)  0.496 ms  0.239 ms  0.307 ms\n 2  192.168.255.1 (192.168.255.1)  6.442 ms  6.241 ms  6.395 ms\n 3  * * *\n 4  * * *\n 5  * * *\n 6  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  11.496 ms  10.359 ms  17.820 ms\n 7  212.48.194.212 (212.48.194.212)  18.821 ms  13.393 ms  15.142 ms\n 8  188.254.2.6 (188.254.2.6)  35.730 ms 188.254.2.4 (188.254.2.4)  35.594 ms  35.397 ms\n 9  87.226.194.47 (87.226.194.47)  52.928 ms  52.816 ms  40.230 ms\n10  74.125.244.180 (74.125.244.180)  38.228 ms 74.125.244.132 (74.125.244.132)  33.673 ms  46.706 ms\n11  142.251.61.219 (142.251.61.219)  42.094 ms  33.875 ms 216.239.48.163 (216.239.48.163)  58.363 ms\n12  142.251.51.187 (142.251.51.187)  33.523 ms  33.404 ms 216.239.58.53 (216.239.58.53)  37.688 ms\n13  * 142.250.209.171 (142.250.209.171)  44.028 ms *\n14  * * *\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  * * *\n22  * dns.google (8.8.8.8)  52.014 ms *', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:41.867331', 'stderr': '', 'delta': '0:00:16.299903', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.0.1)  0.496 ms  0.239 ms  0.307 ms', ' 2  192.168.255.1 (192.168.255.1)  6.442 ms  6.241 ms  6.395 ms', ' 3  * * *', ' 4  * * *', ' 5  * * *', ' 6  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  11.496 ms  10.359 ms  17.820 ms', ' 7  212.48.194.212 (212.48.194.212)  18.821 ms  13.393 ms  15.142 ms', ' 8  188.254.2.6 (188.254.2.6)  35.730 ms 188.254.2.4 (188.254.2.4)  35.594 ms  35.397 ms', ' 9  87.226.194.47 (87.226.194.47)  52.928 ms  52.816 ms  40.230 ms', '10  74.125.244.180 (74.125.244.180)  38.228 ms 74.125.244.132 (74.125.244.132)  33.673 ms  46.706 ms', '11  142.251.61.219 (142.251.61.219)  42.094 ms  33.875 ms 216.239.48.163 (216.239.48.163)  58.363 ms', '12  142.251.51.187 (142.251.51.187)  33.523 ms  33.404 ms 216.239.58.53 (216.239.58.53)  37.688 ms', '13  * 142.250.209.171 (142.250.209.171)  44.028 ms *', '14  * * *', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  * * *', '22  * dns.google (8.8.8.8)  52.014 ms *'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [office1Router -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:44:58.234188', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.0.33)  1.253 ms  1.063 ms  1.186 ms\n 2  192.168.255.1 (192.168.255.1)  5.215 ms  5.159 ms  5.268 ms\n 3  * * *\n 4  * * *\n 5  * * *\n 6  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  16.892 ms  32.552 ms  32.004 ms\n 7  212.48.194.212 (212.48.194.212)  33.068 ms  21.481 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  27.478 ms\n 8  188.254.2.4 (188.254.2.4)  33.421 ms  40.776 ms 188.254.2.6 (188.254.2.6)  35.940 ms\n 9  87.226.194.47 (87.226.194.47)  40.329 ms  40.016 ms  30.921 ms\n10  74.125.244.180 (74.125.244.180)  49.964 ms 74.125.244.132 (74.125.244.132)  44.561 ms  40.944 ms\n11  72.14.232.85 (72.14.232.85)  37.267 ms  36.917 ms 142.251.61.219 (142.251.61.219)  44.391 ms\n12  216.239.49.113 (216.239.49.113)  58.956 ms 142.250.208.23 (142.250.208.23)  37.592 ms 142.251.51.187 (142.251.51.187)  44.728 ms\n13  * 72.14.237.201 (72.14.237.201)  43.965 ms 172.253.51.249 (172.253.51.249)  43.643 ms\n14  * * *\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  * * *\n22  * * *\n23  dns.google (8.8.8.8)  42.932 ms  44.078 ms *', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:42.204184', 'stderr': '', 'delta': '0:00:16.030004', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.0.33)  1.253 ms  1.063 ms  1.186 ms', ' 2  192.168.255.1 (192.168.255.1)  5.215 ms  5.159 ms  5.268 ms', ' 3  * * *', ' 4  * * *', ' 5  * * *', ' 6  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  16.892 ms  32.552 ms  32.004 ms', ' 7  212.48.194.212 (212.48.194.212)  33.068 ms  21.481 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  27.478 ms', ' 8  188.254.2.4 (188.254.2.4)  33.421 ms  40.776 ms 188.254.2.6 (188.254.2.6)  35.940 ms', ' 9  87.226.194.47 (87.226.194.47)  40.329 ms  40.016 ms  30.921 ms', '10  74.125.244.180 (74.125.244.180)  49.964 ms 74.125.244.132 (74.125.244.132)  44.561 ms  40.944 ms', '11  72.14.232.85 (72.14.232.85)  37.267 ms  36.917 ms 142.251.61.219 (142.251.61.219)  44.391 ms', '12  216.239.49.113 (216.239.49.113)  58.956 ms 142.250.208.23 (142.250.208.23)  37.592 ms 142.251.51.187 (142.251.51.187)  44.728 ms', '13  * 72.14.237.201 (72.14.237.201)  43.965 ms 172.253.51.249 (172.253.51.249)  43.643 ms', '14  * * *', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  * * *', '22  * * *', '23  dns.google (8.8.8.8)  42.932 ms  44.078 ms *'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [inetRouter -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:44:52.803944', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (10.0.2.2)  5.289 ms  5.058 ms  4.481 ms\n 2  * * *\n 3  * * *\n 4  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  12.562 ms  24.379 ms  24.432 ms\n 5  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  24.524 ms 212.48.194.212 (212.48.194.212)  24.609 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  28.671 ms\n 6  188.254.2.4 (188.254.2.4)  33.531 ms 188.254.2.6 (188.254.2.6)  29.627 ms  30.288 ms\n 7  87.226.194.47 (87.226.194.47)  36.355 ms  35.816 ms  36.748 ms\n 8  74.125.244.132 (74.125.244.132)  53.706 ms 74.125.244.180 (74.125.244.180)  55.330 ms  55.168 ms\n 9  216.239.48.163 (216.239.48.163)  54.996 ms 72.14.232.85 (72.14.232.85)  54.847 ms 142.251.61.219 (142.251.61.219)  38.585 ms\n10  142.251.61.221 (142.251.61.221)  41.049 ms  42.024 ms 142.251.51.187 (142.251.51.187)  47.723 ms\n11  * * 216.239.63.25 (216.239.63.25)  38.257 ms\n12  * * *\n13  * * *\n14  * * *\n15  * * *\n16  * * *\n17  * * *\n18  * * dns.google (8.8.8.8)  44.000 ms', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:42.283152', 'stderr': '', 'delta': '0:00:10.520792', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (10.0.2.2)  5.289 ms  5.058 ms  4.481 ms', ' 2  * * *', ' 3  * * *', ' 4  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  12.562 ms  24.379 ms  24.432 ms', ' 5  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  24.524 ms 212.48.194.212 (212.48.194.212)  24.609 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  28.671 ms', ' 6  188.254.2.4 (188.254.2.4)  33.531 ms 188.254.2.6 (188.254.2.6)  29.627 ms  30.288 ms', ' 7  87.226.194.47 (87.226.194.47)  36.355 ms  35.816 ms  36.748 ms', ' 8  74.125.244.132 (74.125.244.132)  53.706 ms 74.125.244.180 (74.125.244.180)  55.330 ms  55.168 ms', ' 9  216.239.48.163 (216.239.48.163)  54.996 ms 72.14.232.85 (72.14.232.85)  54.847 ms 142.251.61.219 (142.251.61.219)  38.585 ms', '10  142.251.61.221 (142.251.61.221)  41.049 ms  42.024 ms 142.251.51.187 (142.251.51.187)  47.723 ms', '11  * * 216.239.63.25 (216.239.63.25)  38.257 ms', '12  * * *', '13  * * *', '14  * * *', '15  * * *', '16  * * *', '17  * * *', '18  * * dns.google (8.8.8.8)  44.000 ms'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [office2Router -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:45:09.698785', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.0.33)  0.398 ms  0.165 ms  0.219 ms\n 2  192.168.255.1 (192.168.255.1)  11.663 ms  11.412 ms  11.234 ms\n 3  * * *\n 4  * * *\n 5  * * *\n 6  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  13.415 ms  18.061 ms  17.653 ms\n 7  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  12.422 ms 212.48.194.212 (212.48.194.212)  18.972 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  21.756 ms\n 8  188.254.2.6 (188.254.2.6)  43.047 ms 188.254.2.4 (188.254.2.4)  34.500 ms  33.248 ms\n 9  87.226.194.47 (87.226.194.47)  44.739 ms  36.638 ms  30.139 ms\n10  74.125.244.180 (74.125.244.180)  42.475 ms 74.125.244.132 (74.125.244.132)  24.193 ms  29.116 ms\n11  142.251.61.219 (142.251.61.219)  32.608 ms 216.239.48.163 (216.239.48.163)  31.958 ms  31.693 ms\n12  142.251.61.221 (142.251.61.221)  30.900 ms  34.501 ms 142.250.56.125 (142.250.56.125)  45.582 ms\n13  * 209.85.254.179 (209.85.254.179)  29.633 ms 216.239.47.173 (216.239.47.173)  39.541 ms\n14  * * *\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  * * *\n22  * dns.google (8.8.8.8)  39.513 ms  40.180 ms', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:53.844158', 'stderr': '', 'delta': '0:00:15.854627', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.0.33)  0.398 ms  0.165 ms  0.219 ms', ' 2  192.168.255.1 (192.168.255.1)  11.663 ms  11.412 ms  11.234 ms', ' 3  * * *', ' 4  * * *', ' 5  * * *', ' 6  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  13.415 ms  18.061 ms  17.653 ms', ' 7  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  12.422 ms 212.48.194.212 (212.48.194.212)  18.972 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  21.756 ms', ' 8  188.254.2.6 (188.254.2.6)  43.047 ms 188.254.2.4 (188.254.2.4)  34.500 ms  33.248 ms', ' 9  87.226.194.47 (87.226.194.47)  44.739 ms  36.638 ms  30.139 ms', '10  74.125.244.180 (74.125.244.180)  42.475 ms 74.125.244.132 (74.125.244.132)  24.193 ms  29.116 ms', '11  142.251.61.219 (142.251.61.219)  32.608 ms 216.239.48.163 (216.239.48.163)  31.958 ms  31.693 ms', '12  142.251.61.221 (142.251.61.221)  30.900 ms  34.501 ms 142.250.56.125 (142.250.56.125)  45.582 ms', '13  * 209.85.254.179 (209.85.254.179)  29.633 ms 216.239.47.173 (216.239.47.173)  39.541 ms', '14  * * *', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  * * *', '22  * dns.google (8.8.8.8)  39.513 ms  40.180 ms'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [testServer1 -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:45:15.404449', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.2.65)  0.826 ms  0.460 ms  0.834 ms\n 2  192.168.0.33 (192.168.0.33)  1.738 ms  1.310 ms  0.816 ms\n 3  192.168.255.1 (192.168.255.1)  1.486 ms  3.828 ms  4.449 ms\n 4  * * *\n 5  * * *\n 6  * * *\n 7  * * *\n 8  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  31.013 ms  29.406 ms 212.48.194.212 (212.48.194.212)  33.643 ms\n 9  188.254.2.6 (188.254.2.6)  45.548 ms 188.254.2.4 (188.254.2.4)  30.602 ms 188.254.2.6 (188.254.2.6)  39.138 ms\n10  87.226.194.47 (87.226.194.47)  30.976 ms  32.271 ms  29.862 ms\n11  74.125.244.132 (74.125.244.132)  36.426 ms 74.125.244.180 (74.125.244.180)  30.541 ms 74.125.244.132 (74.125.244.132)  26.141 ms\n12  142.251.61.219 (142.251.61.219)  32.886 ms  34.510 ms  34.152 ms\n13  142.251.51.187 (142.251.51.187)  52.318 ms 142.250.210.45 (142.250.210.45)  39.675 ms 142.251.61.221 (142.251.61.221)  44.911 ms\n14  72.14.236.73 (72.14.236.73)  47.896 ms * 172.253.79.115 (172.253.79.115)  39.785 ms\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  * * *\n22  * * *\n23  * * *\n24  dns.google (8.8.8.8)  54.887 ms  61.805 ms  55.062 ms', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:59.433713', 'stderr': '', 'delta': '0:00:15.970736', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.2.65)  0.826 ms  0.460 ms  0.834 ms', ' 2  192.168.0.33 (192.168.0.33)  1.738 ms  1.310 ms  0.816 ms', ' 3  192.168.255.1 (192.168.255.1)  1.486 ms  3.828 ms  4.449 ms', ' 4  * * *', ' 5  * * *', ' 6  * * *', ' 7  * * *', ' 8  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  31.013 ms  29.406 ms 212.48.194.212 (212.48.194.212)  33.643 ms', ' 9  188.254.2.6 (188.254.2.6)  45.548 ms 188.254.2.4 (188.254.2.4)  30.602 ms 188.254.2.6 (188.254.2.6)  39.138 ms', '10  87.226.194.47 (87.226.194.47)  30.976 ms  32.271 ms  29.862 ms', '11  74.125.244.132 (74.125.244.132)  36.426 ms 74.125.244.180 (74.125.244.180)  30.541 ms 74.125.244.132 (74.125.244.132)  26.141 ms', '12  142.251.61.219 (142.251.61.219)  32.886 ms  34.510 ms  34.152 ms', '13  142.251.51.187 (142.251.51.187)  52.318 ms 142.250.210.45 (142.250.210.45)  39.675 ms 142.251.61.221 (142.251.61.221)  44.911 ms', '14  72.14.236.73 (72.14.236.73)  47.896 ms * 172.253.79.115 (172.253.79.115)  39.785 ms', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  * * *', '22  * * *', '23  * * *', '24  dns.google (8.8.8.8)  54.887 ms  61.805 ms  55.062 ms'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [office2Server -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:45:15.591475', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.1.193)  0.938 ms  0.600 ms  0.359 ms\n 2  192.168.0.33 (192.168.0.33)  0.943 ms  2.009 ms  1.705 ms\n 3  192.168.255.1 (192.168.255.1)  1.999 ms  1.731 ms  1.474 ms\n 4  * * *\n 5  * * *\n 6  * * *\n 7  * * *\n 8  212.48.194.212 (212.48.194.212)  30.486 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  30.932 ms 212.48.194.212 (212.48.194.212)  37.691 ms\n 9  188.254.2.6 (188.254.2.6)  58.619 ms  38.859 ms  38.335 ms\n10  87.226.194.47 (87.226.194.47)  50.109 ms  28.947 ms  31.173 ms\n11  74.125.244.180 (74.125.244.180)  32.061 ms 74.125.244.132 (74.125.244.132)  27.923 ms 74.125.244.180 (74.125.244.180)  35.241 ms\n12  72.14.232.85 (72.14.232.85)  33.872 ms 216.239.48.163 (216.239.48.163)  34.933 ms 72.14.232.85 (72.14.232.85)  35.209 ms\n13  142.251.51.187 (142.251.51.187)  38.743 ms 172.253.51.239 (172.253.51.239)  59.866 ms 142.251.61.221 (142.251.61.221)  56.157 ms\n14  142.250.209.161 (142.250.209.161)  45.083 ms * 142.250.56.221 (142.250.56.221)  31.440 ms\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  * * *\n22  * * *\n23  dns.google (8.8.8.8)  55.651 ms *  55.315 ms', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:59.384446', 'stderr': '', 'delta': '0:00:16.207029', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.1.193)  0.938 ms  0.600 ms  0.359 ms', ' 2  192.168.0.33 (192.168.0.33)  0.943 ms  2.009 ms  1.705 ms', ' 3  192.168.255.1 (192.168.255.1)  1.999 ms  1.731 ms  1.474 ms', ' 4  * * *', ' 5  * * *', ' 6  * * *', ' 7  * * *', ' 8  212.48.194.212 (212.48.194.212)  30.486 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  30.932 ms 212.48.194.212 (212.48.194.212)  37.691 ms', ' 9  188.254.2.6 (188.254.2.6)  58.619 ms  38.859 ms  38.335 ms', '10  87.226.194.47 (87.226.194.47)  50.109 ms  28.947 ms  31.173 ms', '11  74.125.244.180 (74.125.244.180)  32.061 ms 74.125.244.132 (74.125.244.132)  27.923 ms 74.125.244.180 (74.125.244.180)  35.241 ms', '12  72.14.232.85 (72.14.232.85)  33.872 ms 216.239.48.163 (216.239.48.163)  34.933 ms 72.14.232.85 (72.14.232.85)  35.209 ms', '13  142.251.51.187 (142.251.51.187)  38.743 ms 172.253.51.239 (172.253.51.239)  59.866 ms 142.251.61.221 (142.251.61.221)  56.157 ms', '14  142.250.209.161 (142.250.209.161)  45.083 ms * 142.250.56.221 (142.250.56.221)  31.440 ms', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  * * *', '22  * * *', '23  dns.google (8.8.8.8)  55.651 ms *  55.315 ms'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [testServer2 -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:45:15.556384', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.2.65)  0.685 ms  0.449 ms  0.395 ms\n 2  192.168.0.33 (192.168.0.33)  1.176 ms  0.662 ms  1.505 ms\n 3  192.168.255.1 (192.168.255.1)  2.767 ms  2.603 ms  2.416 ms\n 4  * * *\n 5  * * *\n 6  * * *\n 7  * * *\n 8  212.48.194.212 (212.48.194.212)  28.216 ms  30.936 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  30.782 ms\n 9  188.254.2.6 (188.254.2.6)  51.563 ms 188.254.2.4 (188.254.2.4)  29.908 ms  29.270 ms\n10  87.226.194.47 (87.226.194.47)  38.504 ms  25.635 ms  30.619 ms\n11  74.125.244.180 (74.125.244.180)  29.865 ms  24.351 ms  43.346 ms\n12  72.14.232.85 (72.14.232.85)  44.626 ms 142.251.61.219 (142.251.61.219)  44.637 ms  50.213 ms\n13  142.251.51.187 (142.251.51.187)  42.620 ms 172.253.79.113 (172.253.79.113)  36.546 ms 142.250.210.45 (142.250.210.45)  31.032 ms\n14  216.239.47.173 (216.239.47.173)  33.496 ms * 172.253.51.237 (172.253.51.237)  31.673 ms\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  * * *\n22  * * *\n23  dns.google (8.8.8.8)  48.648 ms * *', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:59.567700', 'stderr': '', 'delta': '0:00:15.988684', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.2.65)  0.685 ms  0.449 ms  0.395 ms', ' 2  192.168.0.33 (192.168.0.33)  1.176 ms  0.662 ms  1.505 ms', ' 3  192.168.255.1 (192.168.255.1)  2.767 ms  2.603 ms  2.416 ms', ' 4  * * *', ' 5  * * *', ' 6  * * *', ' 7  * * *', ' 8  212.48.194.212 (212.48.194.212)  28.216 ms  30.936 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  30.782 ms', ' 9  188.254.2.6 (188.254.2.6)  51.563 ms 188.254.2.4 (188.254.2.4)  29.908 ms  29.270 ms', '10  87.226.194.47 (87.226.194.47)  38.504 ms  25.635 ms  30.619 ms', '11  74.125.244.180 (74.125.244.180)  29.865 ms  24.351 ms  43.346 ms', '12  72.14.232.85 (72.14.232.85)  44.626 ms 142.251.61.219 (142.251.61.219)  44.637 ms  50.213 ms', '13  142.251.51.187 (142.251.51.187)  42.620 ms 172.253.79.113 (172.253.79.113)  36.546 ms 142.250.210.45 (142.250.210.45)  31.032 ms', '14  216.239.47.173 (216.239.47.173)  33.496 ms * 172.253.51.237 (172.253.51.237)  31.673 ms', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  * * *', '22  * * *', '23  dns.google (8.8.8.8)  48.648 ms * *'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [testClient1 -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:45:15.690617', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.2.65)  0.544 ms  2.712 ms  2.578 ms\n 2  192.168.0.33 (192.168.0.33)  2.942 ms  2.808 ms  2.980 ms\n 3  192.168.255.1 (192.168.255.1)  5.304 ms  5.124 ms  4.983 ms\n 4  * * *\n 5  * * *\n 6  * * *\n 7  * * *\n 8  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  32.995 ms  31.491 ms  35.760 ms\n 9  188.254.2.6 (188.254.2.6)  44.100 ms  35.062 ms  30.896 ms\n10  87.226.194.47 (87.226.194.47)  30.668 ms  27.026 ms  27.634 ms\n11  74.125.244.180 (74.125.244.180)  26.464 ms 74.125.244.132 (74.125.244.132)  37.853 ms  30.305 ms\n12  216.239.48.163 (216.239.48.163)  30.617 ms 72.14.232.85 (72.14.232.85)  28.295 ms  28.763 ms\n13  209.85.254.135 (209.85.254.135)  32.913 ms 216.239.47.167 (216.239.47.167)  29.363 ms 142.251.51.187 (142.251.51.187)  39.842 ms\n14  72.14.236.73 (72.14.236.73)  31.269 ms * *\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  * * *\n22  * * *\n23  * dns.google (8.8.8.8)  61.928 ms  57.540 ms', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:44:59.581891', 'stderr': '', 'delta': '0:00:16.108726', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.2.65)  0.544 ms  2.712 ms  2.578 ms', ' 2  192.168.0.33 (192.168.0.33)  2.942 ms  2.808 ms  2.980 ms', ' 3  192.168.255.1 (192.168.255.1)  5.304 ms  5.124 ms  4.983 ms', ' 4  * * *', ' 5  * * *', ' 6  * * *', ' 7  * * *', ' 8  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  32.995 ms  31.491 ms  35.760 ms', ' 9  188.254.2.6 (188.254.2.6)  44.100 ms  35.062 ms  30.896 ms', '10  87.226.194.47 (87.226.194.47)  30.668 ms  27.026 ms  27.634 ms', '11  74.125.244.180 (74.125.244.180)  26.464 ms 74.125.244.132 (74.125.244.132)  37.853 ms  30.305 ms', '12  216.239.48.163 (216.239.48.163)  30.617 ms 72.14.232.85 (72.14.232.85)  28.295 ms  28.763 ms', '13  209.85.254.135 (209.85.254.135)  32.913 ms 216.239.47.167 (216.239.47.167)  29.363 ms 142.251.51.187 (142.251.51.187)  39.842 ms', '14  72.14.236.73 (72.14.236.73)  31.269 ms * *', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  * * *', '22  * * *', '23  * dns.google (8.8.8.8)  61.928 ms  57.540 ms'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})
changed: [testClient2 -> localhost] => (item={'changed': True, 'end': '2021-09-07 21:45:26.905327', 'stdout': 'traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets\n 1  gateway (192.168.2.65)  2.857 ms  2.637 ms  2.486 ms\n 2  192.168.0.33 (192.168.0.33)  5.097 ms  4.916 ms  4.753 ms\n 3  192.168.255.1 (192.168.255.1)  4.858 ms  5.898 ms  5.756 ms\n 4  * * *\n 5  * * *\n 6  * * *\n 7  * * *\n 8  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  24.668 ms 212.48.194.212 (212.48.194.212)  25.332 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  25.189 ms\n 9  188.254.2.4 (188.254.2.4)  75.665 ms 188.254.2.6 (188.254.2.6)  71.644 ms  73.809 ms\n10  87.226.194.47 (87.226.194.47)  73.659 ms  36.438 ms  28.578 ms\n11  74.125.244.132 (74.125.244.132)  49.853 ms  29.913 ms  36.673 ms\n12  72.14.232.85 (72.14.232.85)  26.814 ms 142.251.61.219 (142.251.61.219)  32.171 ms 72.14.232.85 (72.14.232.85)  29.363 ms\n13  172.253.64.113 (172.253.64.113)  40.648 ms 142.251.61.221 (142.251.61.221)  37.388 ms 72.14.237.199 (72.14.237.199)  47.688 ms\n14  * 72.14.237.201 (72.14.237.201)  33.024 ms 216.239.40.61 (216.239.40.61)  36.936 ms\n15  * * *\n16  * * *\n17  * * *\n18  * * *\n19  * * *\n20  * * *\n21  * * *\n22  * * *\n23  * dns.google (8.8.8.8)  40.873 ms  42.584 ms', 'cmd': 'traceroute 8.8.8.8', 'rc': 0, 'start': '2021-09-07 21:45:10.436649', 'stderr': '', 'delta': '0:00:16.468678', 'invocation': {'module_args': {'creates': None, 'executable': None, '_uses_shell': True, 'strip_empty_ends': True, '_raw_params': 'traceroute 8.8.8.8', 'removes': None, 'argv': None, 'warn': False, 'chdir': None, 'stdin_add_newline': True, 'stdin': None}}, 'stdout_lines': ['traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets', ' 1  gateway (192.168.2.65)  2.857 ms  2.637 ms  2.486 ms', ' 2  192.168.0.33 (192.168.0.33)  5.097 ms  4.916 ms  4.753 ms', ' 3  192.168.255.1 (192.168.255.1)  4.858 ms  5.898 ms  5.756 ms', ' 4  * * *', ' 5  * * *', ' 6  * * *', ' 7  * * *', ' 8  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  24.668 ms 212.48.194.212 (212.48.194.212)  25.332 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  25.189 ms', ' 9  188.254.2.4 (188.254.2.4)  75.665 ms 188.254.2.6 (188.254.2.6)  71.644 ms  73.809 ms', '10  87.226.194.47 (87.226.194.47)  73.659 ms  36.438 ms  28.578 ms', '11  74.125.244.132 (74.125.244.132)  49.853 ms  29.913 ms  36.673 ms', '12  72.14.232.85 (72.14.232.85)  26.814 ms 142.251.61.219 (142.251.61.219)  32.171 ms 72.14.232.85 (72.14.232.85)  29.363 ms', '13  172.253.64.113 (172.253.64.113)  40.648 ms 142.251.61.221 (142.251.61.221)  37.388 ms 72.14.237.199 (72.14.237.199)  47.688 ms', '14  * 72.14.237.201 (72.14.237.201)  33.024 ms 216.239.40.61 (216.239.40.61)  36.936 ms', '15  * * *', '16  * * *', '17  * * *', '18  * * *', '19  * * *', '20  * * *', '21  * * *', '22  * * *', '23  * dns.google (8.8.8.8)  40.873 ms  42.584 ms'], 'stderr_lines': [], 'failed': False, 'item': '8.8.8.8', 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
centralRouter              : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
centralServer              : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
inetRouter                 : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
office1Router              : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
office1Server              : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
office2Router              : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
office2Server              : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
testClient1                : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
testClient2                : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
testServer1                : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
testServer2                : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   


```

</details>

Проверка узла выхода `traceroute 8.8.8.8`


<details><summary>см. centralRouter</summary>

```text
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  gateway (192.168.255.1)  0.350 ms  0.242 ms  0.300 ms
 2  * * *
 3  * * *
 4  * * *
 5  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  13.778 ms  13.525 ms  13.298 ms
 6  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  22.106 ms  13.160 ms 212.48.194.212 (212.48.194.212)  13.102 ms
 7  188.254.2.6 (188.254.2.6)  39.954 ms  41.827 ms 188.254.2.4 (188.254.2.4)  34.916 ms
 8  87.226.194.47 (87.226.194.47)  36.409 ms  36.708 ms  37.825 ms
 9  74.125.244.180 (74.125.244.180)  29.243 ms 74.125.244.132 (74.125.244.132)  23.541 ms  38.770 ms
10  72.14.232.85 (72.14.232.85)  35.928 ms 216.239.48.163 (216.239.48.163)  37.993 ms 142.251.61.219 (142.251.61.219)  37.192 ms
11  142.251.61.221 (142.251.61.221)  60.420 ms  34.456 ms 142.251.51.187 (142.251.51.187)  46.276 ms
12  216.239.54.201 (216.239.54.201)  38.905 ms 216.239.63.65 (216.239.63.65)  36.891 ms *
13  * * *
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  dns.google (8.8.8.8)  35.819 ms  36.911 ms *
```

</details>

<details><summary>см. centralServer</summary>

```text
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  gateway (192.168.0.1)  0.496 ms  0.239 ms  0.307 ms
 2  192.168.255.1 (192.168.255.1)  6.442 ms  6.241 ms  6.395 ms
 3  * * *
 4  * * *
 5  * * *
 6  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  11.496 ms  10.359 ms  17.820 ms
 7  212.48.194.212 (212.48.194.212)  18.821 ms  13.393 ms  15.142 ms
 8  188.254.2.6 (188.254.2.6)  35.730 ms 188.254.2.4 (188.254.2.4)  35.594 ms  35.397 ms
 9  87.226.194.47 (87.226.194.47)  52.928 ms  52.816 ms  40.230 ms
10  74.125.244.180 (74.125.244.180)  38.228 ms 74.125.244.132 (74.125.244.132)  33.673 ms  46.706 ms
11  142.251.61.219 (142.251.61.219)  42.094 ms  33.875 ms 216.239.48.163 (216.239.48.163)  58.363 ms
12  142.251.51.187 (142.251.51.187)  33.523 ms  33.404 ms 216.239.58.53 (216.239.58.53)  37.688 ms
13  * 142.250.209.171 (142.250.209.171)  44.028 ms *
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * dns.google (8.8.8.8)  52.014 ms *
```

</details>

<details><summary>см. netRouter</summary>

```text
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  gateway (10.0.2.2)  5.289 ms  5.058 ms  4.481 ms
 2  * * *
 3  * * *
 4  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  12.562 ms  24.379 ms  24.432 ms
 5  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  24.524 ms 212.48.194.212 (212.48.194.212)  24.609 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  28.671 ms
 6  188.254.2.4 (188.254.2.4)  33.531 ms 188.254.2.6 (188.254.2.6)  29.627 ms  30.288 ms
 7  87.226.194.47 (87.226.194.47)  36.355 ms  35.816 ms  36.748 ms
 8  74.125.244.132 (74.125.244.132)  53.706 ms 74.125.244.180 (74.125.244.180)  55.330 ms  55.168 ms
 9  216.239.48.163 (216.239.48.163)  54.996 ms 72.14.232.85 (72.14.232.85)  54.847 ms 142.251.61.219 (142.251.61.219)  38.585 ms
10  142.251.61.221 (142.251.61.221)  41.049 ms  42.024 ms 142.251.51.187 (142.251.51.187)  47.723 ms
11  * * 216.239.63.25 (216.239.63.25)  38.257 ms
12  * * *
13  * * *
14  * * *
15  * * *
16  * * *
17  * * *
18  * * dns.google (8.8.8.8)  44.000 ms
```

</details>

<details><summary>см. office1Router</summary>

```text
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  gateway (192.168.0.33)  1.253 ms  1.063 ms  1.186 ms
 2  192.168.255.1 (192.168.255.1)  5.215 ms  5.159 ms  5.268 ms
 3  * * *
 4  * * *
 5  * * *
 6  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  16.892 ms  32.552 ms  32.004 ms
 7  212.48.194.212 (212.48.194.212)  33.068 ms  21.481 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  27.478 ms
 8  188.254.2.4 (188.254.2.4)  33.421 ms  40.776 ms 188.254.2.6 (188.254.2.6)  35.940 ms
 9  87.226.194.47 (87.226.194.47)  40.329 ms  40.016 ms  30.921 ms
10  74.125.244.180 (74.125.244.180)  49.964 ms 74.125.244.132 (74.125.244.132)  44.561 ms  40.944 ms
11  72.14.232.85 (72.14.232.85)  37.267 ms  36.917 ms 142.251.61.219 (142.251.61.219)  44.391 ms
12  216.239.49.113 (216.239.49.113)  58.956 ms 142.250.208.23 (142.250.208.23)  37.592 ms 142.251.51.187 (142.251.51.187)  44.728 ms
13  * 72.14.237.201 (72.14.237.201)  43.965 ms 172.253.51.249 (172.253.51.249)  43.643 ms
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * * *
23  dns.google (8.8.8.8)  42.932 ms  44.078 ms *
```

</details>

<details><summary>см. office1Server</summary>

```text
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  gateway (192.168.2.193)  0.435 ms  0.479 ms  4.019 ms
 2  192.168.0.33 (192.168.0.33)  6.004 ms  5.804 ms  5.626 ms
 3  192.168.255.1 (192.168.255.1)  14.382 ms  14.232 ms  14.015 ms
 4  * * *
 5  * * *
 6  * * *
 7  * * *
 8  212.48.194.212 (212.48.194.212)  20.940 ms  24.038 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  23.887 ms
 9  188.254.2.6 (188.254.2.6)  37.753 ms 188.254.2.4 (188.254.2.4)  42.181 ms 188.254.2.6 (188.254.2.6)  38.467 ms
10  87.226.194.47 (87.226.194.47)  39.091 ms  31.687 ms  44.064 ms
11  74.125.244.180 (74.125.244.180)  34.177 ms 74.125.244.132 (74.125.244.132)  42.700 ms 74.125.244.180 (74.125.244.180)  37.810 ms
12  216.239.48.163 (216.239.48.163)  40.886 ms  40.507 ms 72.14.232.85 (72.14.232.85)  40.018 ms
13  142.250.233.27 (142.250.233.27)  39.559 ms 142.250.208.23 (142.250.208.23)  56.343 ms 209.85.246.111 (209.85.246.111)  48.645 ms
14  142.250.56.217 (142.250.56.217)  48.495 ms 216.239.57.5 (216.239.57.5)  48.353 ms *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * * *
23  dns.google (8.8.8.8)  45.760 ms * *
```

</details>

<details><summary>см. office2Router</summary>

```text
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  gateway (192.168.0.33)  0.398 ms  0.165 ms  0.219 ms
 2  192.168.255.1 (192.168.255.1)  11.663 ms  11.412 ms  11.234 ms
 3  * * *
 4  * * *
 5  * * *
 6  mrsk-bras5.sz.ip.rostelecom.ru (212.48.195.203)  13.415 ms  18.061 ms  17.653 ms
 7  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  12.422 ms 212.48.194.212 (212.48.194.212)  18.972 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  21.756 ms
 8  188.254.2.6 (188.254.2.6)  43.047 ms 188.254.2.4 (188.254.2.4)  34.500 ms  33.248 ms
 9  87.226.194.47 (87.226.194.47)  44.739 ms  36.638 ms  30.139 ms
10  74.125.244.180 (74.125.244.180)  42.475 ms 74.125.244.132 (74.125.244.132)  24.193 ms  29.116 ms
11  142.251.61.219 (142.251.61.219)  32.608 ms 216.239.48.163 (216.239.48.163)  31.958 ms  31.693 ms
12  142.251.61.221 (142.251.61.221)  30.900 ms  34.501 ms 142.250.56.125 (142.250.56.125)  45.582 ms
13  * 209.85.254.179 (209.85.254.179)  29.633 ms 216.239.47.173 (216.239.47.173)  39.541 ms
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * dns.google (8.8.8.8)  39.513 ms  40.180 ms
```

</details>

<details><summary>см. office2Server</summary>

```text
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  gateway (192.168.1.193)  0.938 ms  0.600 ms  0.359 ms
 2  192.168.0.33 (192.168.0.33)  0.943 ms  2.009 ms  1.705 ms
 3  192.168.255.1 (192.168.255.1)  1.999 ms  1.731 ms  1.474 ms
 4  * * *
 5  * * *
 6  * * *
 7  * * *
 8  212.48.194.212 (212.48.194.212)  30.486 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  30.932 ms 212.48.194.212 (212.48.194.212)  37.691 ms
 9  188.254.2.6 (188.254.2.6)  58.619 ms  38.859 ms  38.335 ms
10  87.226.194.47 (87.226.194.47)  50.109 ms  28.947 ms  31.173 ms
11  74.125.244.180 (74.125.244.180)  32.061 ms 74.125.244.132 (74.125.244.132)  27.923 ms 74.125.244.180 (74.125.244.180)  35.241 ms
12  72.14.232.85 (72.14.232.85)  33.872 ms 216.239.48.163 (216.239.48.163)  34.933 ms 72.14.232.85 (72.14.232.85)  35.209 ms
13  142.251.51.187 (142.251.51.187)  38.743 ms 172.253.51.239 (172.253.51.239)  59.866 ms 142.251.61.221 (142.251.61.221)  56.157 ms
14  142.250.209.161 (142.250.209.161)  45.083 ms * 142.250.56.221 (142.250.56.221)  31.440 ms
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * * *
23  dns.google (8.8.8.8)  55.651 ms *  55.315 ms
```

</details>

<details><summary>см. testClient1</summary>

```text
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  gateway (192.168.2.65)  0.544 ms  2.712 ms  2.578 ms
 2  192.168.0.33 (192.168.0.33)  2.942 ms  2.808 ms  2.980 ms
 3  192.168.255.1 (192.168.255.1)  5.304 ms  5.124 ms  4.983 ms
 4  * * *
 5  * * *
 6  * * *
 7  * * *
 8  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  32.995 ms  31.491 ms  35.760 ms
 9  188.254.2.6 (188.254.2.6)  44.100 ms  35.062 ms  30.896 ms
10  87.226.194.47 (87.226.194.47)  30.668 ms  27.026 ms  27.634 ms
11  74.125.244.180 (74.125.244.180)  26.464 ms 74.125.244.132 (74.125.244.132)  37.853 ms  30.305 ms
12  216.239.48.163 (216.239.48.163)  30.617 ms 72.14.232.85 (72.14.232.85)  28.295 ms  28.763 ms
13  209.85.254.135 (209.85.254.135)  32.913 ms 216.239.47.167 (216.239.47.167)  29.363 ms 142.251.51.187 (142.251.51.187)  39.842 ms
14  72.14.236.73 (72.14.236.73)  31.269 ms * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * * *
23  * dns.google (8.8.8.8)  61.928 ms  57.540 ms
```

</details>

<details><summary>см. testClient2</summary>

```text
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  gateway (192.168.2.65)  2.857 ms  2.637 ms  2.486 ms
 2  192.168.0.33 (192.168.0.33)  5.097 ms  4.916 ms  4.753 ms
 3  192.168.255.1 (192.168.255.1)  4.858 ms  5.898 ms  5.756 ms
 4  * * *
 5  * * *
 6  * * *
 7  * * *
 8  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  24.668 ms 212.48.194.212 (212.48.194.212)  25.332 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  25.189 ms
 9  188.254.2.4 (188.254.2.4)  75.665 ms 188.254.2.6 (188.254.2.6)  71.644 ms  73.809 ms
10  87.226.194.47 (87.226.194.47)  73.659 ms  36.438 ms  28.578 ms
11  74.125.244.132 (74.125.244.132)  49.853 ms  29.913 ms  36.673 ms
12  72.14.232.85 (72.14.232.85)  26.814 ms 142.251.61.219 (142.251.61.219)  32.171 ms 72.14.232.85 (72.14.232.85)  29.363 ms
13  172.253.64.113 (172.253.64.113)  40.648 ms 142.251.61.221 (142.251.61.221)  37.388 ms 72.14.237.199 (72.14.237.199)  47.688 ms
14  * 72.14.237.201 (72.14.237.201)  33.024 ms 216.239.40.61 (216.239.40.61)  36.936 ms
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * * *
23  * dns.google (8.8.8.8)  40.873 ms  42.584 ms
```

</details>

<details><summary>см. testServer1</summary>

```text
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  gateway (192.168.2.65)  0.826 ms  0.460 ms  0.834 ms
 2  192.168.0.33 (192.168.0.33)  1.738 ms  1.310 ms  0.816 ms
 3  192.168.255.1 (192.168.255.1)  1.486 ms  3.828 ms  4.449 ms
 4  * * *
 5  * * *
 6  * * *
 7  * * *
 8  pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  31.013 ms  29.406 ms 212.48.194.212 (212.48.194.212)  33.643 ms
 9  188.254.2.6 (188.254.2.6)  45.548 ms 188.254.2.4 (188.254.2.4)  30.602 ms 188.254.2.6 (188.254.2.6)  39.138 ms
10  87.226.194.47 (87.226.194.47)  30.976 ms  32.271 ms  29.862 ms
11  74.125.244.132 (74.125.244.132)  36.426 ms 74.125.244.180 (74.125.244.180)  30.541 ms 74.125.244.132 (74.125.244.132)  26.141 ms
12  142.251.61.219 (142.251.61.219)  32.886 ms  34.510 ms  34.152 ms
13  142.251.51.187 (142.251.51.187)  52.318 ms 142.250.210.45 (142.250.210.45)  39.675 ms 142.251.61.221 (142.251.61.221)  44.911 ms
14  72.14.236.73 (72.14.236.73)  47.896 ms * 172.253.79.115 (172.253.79.115)  39.785 ms
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * * *
23  * * *
24  dns.google (8.8.8.8)  54.887 ms  61.805 ms  55.062 ms
```

</details>

<details><summary>см. testServer2</summary>

```text
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  gateway (192.168.2.65)  0.685 ms  0.449 ms  0.395 ms
 2  192.168.0.33 (192.168.0.33)  1.176 ms  0.662 ms  1.505 ms
 3  192.168.255.1 (192.168.255.1)  2.767 ms  2.603 ms  2.416 ms
 4  * * *
 5  * * *
 6  * * *
 7  * * *
 8  212.48.194.212 (212.48.194.212)  28.216 ms  30.936 ms pos14-0-0-s16.E320-1-VLGD.nwtelecom.ru (212.48.194.218)  30.782 ms
 9  188.254.2.6 (188.254.2.6)  51.563 ms 188.254.2.4 (188.254.2.4)  29.908 ms  29.270 ms
10  87.226.194.47 (87.226.194.47)  38.504 ms  25.635 ms  30.619 ms
11  74.125.244.180 (74.125.244.180)  29.865 ms  24.351 ms  43.346 ms
12  72.14.232.85 (72.14.232.85)  44.626 ms 142.251.61.219 (142.251.61.219)  44.637 ms  50.213 ms
13  142.251.51.187 (142.251.51.187)  42.620 ms 172.253.79.113 (172.253.79.113)  36.546 ms 142.250.210.45 (142.250.210.45)  31.032 ms
14  216.239.47.173 (216.239.47.173)  33.496 ms * 172.253.51.237 (172.253.51.237)  31.673 ms
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * * *
23  dns.google (8.8.8.8)  48.648 ms * *
```

</details>
