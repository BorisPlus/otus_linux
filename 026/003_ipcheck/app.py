from networks import networks
import ipaddress

if __name__ == '__main__':
    # python3 ./026/003_ipcheck/app.py > ./026/003_ipcheck/table.md
    hosts = dict()
    print(f'Сегмент сети | имя подсети | IP-адресация | broadcast-IP')
    print(f'--- | --- | --- | ---')
    for segment_name, subnetworks in networks.items():
        for subnetwork_ip, subnetwork_name in subnetworks.items():
            subnetwork_obj = ipaddress.ip_network(subnetwork_ip)
            print(f'{segment_name} | {subnetwork_name} | {subnetwork_ip} | {subnetwork_obj.broadcast_address} ')
