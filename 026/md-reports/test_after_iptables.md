
PLAY [Playbook of tests] *******************************************************

TASK [Gathering Facts] *********************************************************
ok: [inetRouter]
ok: [office1Server]
ok: [centralServer]
ok: [centralRouter]
ok: [office1Router]
ok: [office2Router]
ok: [office2Server]

TASK [../roles/test_001_check_internet_available : test | demostration] ********
ok: [inetRouter] => {
    "msg": "I am inetRouter"
}
ok: [centralRouter] => {
    "msg": "I am centralRouter"
}
ok: [centralServer] => {
    "msg": "I am centralServer"
}
ok: [office1Router] => {
    "msg": "I am office1Router"
}
ok: [office1Server] => {
    "msg": "I am office1Server"
}
ok: [office2Router] => {
    "msg": "I am office2Router"
}
ok: [office2Server] => {
    "msg": "I am office2Server"
}

TASK [../roles/test_001_check_internet_available : test | ping foreign host] ***
failed: [office1Server] (item=8.8.8.8) => {"ansible_loop_var": "item", "changed": true, "cmd": "ping -c 1 -w 2 8.8.8.8", "delta": "0:00:00.022096", "end": "2021-08-11 21:06:50.582330", "item": "8.8.8.8", "msg": "non-zero return code", "rc": 1, "start": "2021-08-11 21:06:50.560234", "stderr": "", "stderr_lines": [], "stdout": "PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.\nFrom 10.0.2.2 icmp_seq=1 Destination Net Unreachable\n\n--- 8.8.8.8 ping statistics ---\n1 packets transmitted, 0 received, +1 errors, 100% packet loss, time 0ms", "stdout_lines": ["PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.", "From 10.0.2.2 icmp_seq=1 Destination Net Unreachable", "", "--- 8.8.8.8 ping statistics ---", "1 packets transmitted, 0 received, +1 errors, 100% packet loss, time 0ms"]}
changed: [centralServer] => (item=8.8.8.8)
changed: [centralRouter] => (item=8.8.8.8)
changed: [office1Router] => (item=8.8.8.8)
changed: [inetRouter] => (item=8.8.8.8)
changed: [centralRouter] => (item=otus.ru)
changed: [office1Server] => (item=otus.ru)
changed: [centralServer] => (item=otus.ru)
changed: [office1Router] => (item=otus.ru)
changed: [inetRouter] => (item=otus.ru)
failed: [office1Server] (item=otus.kz) => {"ansible_loop_var": "item", "changed": true, "cmd": "ping -c 1 -w 2 otus.kz", "delta": "0:00:10.032969", "end": "2021-08-11 21:07:05.084444", "item": "otus.kz", "msg": "non-zero return code", "rc": 2, "start": "2021-08-11 21:06:55.051475", "stderr": "ping: otus.kz: Name or service not known", "stderr_lines": ["ping: otus.kz: Name or service not known"], "stdout": "", "stdout_lines": []}
failed: [centralRouter] (item=otus.kz) => {"ansible_loop_var": "item", "changed": true, "cmd": "ping -c 1 -w 2 otus.kz", "delta": "0:00:10.032355", "end": "2021-08-11 21:07:05.158606", "item": "otus.kz", "msg": "non-zero return code", "rc": 2, "start": "2021-08-11 21:06:55.126251", "stderr": "ping: otus.kz: Name or service not known", "stderr_lines": ["ping: otus.kz: Name or service not known"], "stdout": "", "stdout_lines": []}
failed: [centralServer] (item=otus.kz) => {"ansible_loop_var": "item", "changed": true, "cmd": "ping -c 1 -w 2 otus.kz", "delta": "0:00:10.028709", "end": "2021-08-11 21:07:05.215347", "item": "otus.kz", "msg": "non-zero return code", "rc": 2, "start": "2021-08-11 21:06:55.186638", "stderr": "ping: otus.kz: Name or service not known", "stderr_lines": ["ping: otus.kz: Name or service not known"], "stdout": "", "stdout_lines": []}
failed: [office1Router] (item=otus.kz) => {"ansible_loop_var": "item", "changed": true, "cmd": "ping -c 1 -w 2 otus.kz", "delta": "0:00:10.029623", "end": "2021-08-11 21:07:05.251805", "item": "otus.kz", "msg": "non-zero return code", "rc": 2, "start": "2021-08-11 21:06:55.222182", "stderr": "ping: otus.kz: Name or service not known", "stderr_lines": ["ping: otus.kz: Name or service not known"], "stdout": "", "stdout_lines": []}
failed: [inetRouter] (item=otus.kz) => {"ansible_loop_var": "item", "changed": true, "cmd": "ping -c 1 -w 2 otus.kz", "delta": "0:00:10.025476", "end": "2021-08-11 21:07:05.302088", "item": "otus.kz", "msg": "non-zero return code", "rc": 2, "start": "2021-08-11 21:06:55.276612", "stderr": "ping: otus.kz: Name or service not known", "stderr_lines": ["ping: otus.kz: Name or service not known"], "stdout": "", "stdout_lines": []}
changed: [office2Router] => (item=8.8.8.8)
changed: [office2Server] => (item=8.8.8.8)
changed: [office2Router] => (item=otus.ru)
changed: [office2Server] => (item=otus.ru)
failed: [office2Router] (item=otus.kz) => {"ansible_loop_var": "item", "changed": true, "cmd": "ping -c 1 -w 2 otus.kz", "delta": "0:00:10.033054", "end": "2021-08-11 21:07:19.375269", "item": "otus.kz", "msg": "non-zero return code", "rc": 2, "start": "2021-08-11 21:07:09.342215", "stderr": "ping: otus.kz: Name or service not known", "stderr_lines": ["ping: otus.kz: Name or service not known"], "stdout": "", "stdout_lines": []}
failed: [office2Server] (item=otus.kz) => {"ansible_loop_var": "item", "changed": true, "cmd": "ping -c 1 -w 2 otus.kz", "delta": "0:00:10.027199", "end": "2021-08-11 21:07:19.537549", "item": "otus.kz", "msg": "non-zero return code", "rc": 2, "start": "2021-08-11 21:07:09.510350", "stderr": "ping: otus.kz: Name or service not known", "stderr_lines": ["ping: otus.kz: Name or service not known"], "stdout": "", "stdout_lines": []}

PLAY RECAP *********************************************************************
centralRouter              : ok=2    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   
centralServer              : ok=2    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   
inetRouter                 : ok=2    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   
office1Router              : ok=2    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   
office1Server              : ok=2    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   
office2Router              : ok=2    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   
office2Server              : ok=2    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   

