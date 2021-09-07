#  Доступ из сети в Интернет через единый узел

## Реализация

Воспрос:

Почему это все работ исключительно при ВЫКЛЮЧЕННОМ маскарадинге для сети !192.168.0.0/16?
В моем понимании маскарадинг же должен быть ккак раз включен для форвардинга во вне, например, на 8.8.8.8?

```shell
pwd
./0XX_stand/vm

vagrant destroy -f && vagrant up

python3 v2a.py -o ../ansible/inventories/hosts

cd ../ansible/

ansible-playbook playbooks/routing.yml > ../files/playbooks_routing.txt
ansible-playbook playbooks/internet-router.yml  > ../files/internet-router.txt
ansible-playbook playbooks/test_network_connectivity.yml > ../files/test_network_connectivity.txt
```

[details --no-link]:[playbooks/routing.yml](./0XX_stand/files/playbooks_routing.txt)

[details --no-link]:[playbooks/internet-router.yml](./0XX_stand/files/internet-router.txt)

[details --no-link]:[playbooks/test_network_connectivity.yml](./0XX_stand/files/test_network_connectivity.txt)

[details --no-link]:[playbooks/test_network_connectivity.yml](./0XX_stand/files/test_network_connectivity.txt)

traceroute 8.8.8.8

[details --no-link]:[centralRouter](./0XX_stand/files/traceroute/centralRouter - traceroute 8.8.8.8.txt)
[details --no-link]:[centralServer](./0XX_stand/files/traceroute/centralServer - traceroute 8.8.8.8.txt)
[details --no-link]:[netRouter](./0XX_stand/files/traceroute/inetRouter - traceroute 8.8.8.8.txt)
[details --no-link]:[office1Router](./0XX_stand/files/traceroute/office1Router - traceroute 8.8.8.8.txt)
[details --no-link]:[office1Server](./0XX_stand/files/traceroute/office1Server - traceroute 8.8.8.8.txt)
[details --no-link]:[office2Router](./0XX_stand/files/traceroute/office2Router - traceroute 8.8.8.8.txt)
[details --no-link]:[office2Server](./0XX_stand/files/traceroute/office2Server - traceroute 8.8.8.8.txt)
[details --no-link]:[testClient1](./0XX_stand/files/traceroute/testClient1 - traceroute 8.8.8.8.txt)
[details --no-link]:[testClient2](./0XX_stand/files/traceroute/testClient2 - traceroute 8.8.8.8.txt)
[details --no-link]:[testServer1](./0XX_stand/files/traceroute/testServer1 - traceroute 8.8.8.8.txt)
[details --no-link]:[testServer2](./0XX_stand/files/traceroute/testServer2 - traceroute 8.8.8.8.txt)
