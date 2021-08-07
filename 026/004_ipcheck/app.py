from networks import networks
import ipaddress
import sys

if __name__ == '__main__':

    # python3 ./026/004_ipcheck/app.py md > ./026/004_ipcheck/report.md
    # python3 ./026/004_ipcheck/app.py > ./026/004_ipcheck/report.txt

    all_ips = dict()

    for segment_name, subnetworks in networks.items():
        for subnetwork_ip, subnetwork_name in subnetworks.items():
            subnetwork_obj = ipaddress.ip_network(subnetwork_ip)
            subnetwork_ip_addresses = set(subnetwork_obj.hosts())
            subnetwork_ip_addresses.add(subnetwork_obj.network_address)
            subnetwork_ip_addresses.add(subnetwork_obj.broadcast_address)
            for ip in subnetwork_ip_addresses:
                if ip not in all_ips:
                    all_ips[ip] = set()
                all_ips[ip].add(f'{segment_name}: {subnetwork_ip} - {subnetwork_name}')

    if len(sys.argv) == 1:
        print('IP', 'входит в подсети')
        for ip in all_ips:
            print(ip, all_ips[ip])

    if len(sys.argv) == 2 and sys.argv[1] == 'md':
        intersections_of_netqorks_was_detected = False
        for ip, ip_subnetworks in filter(lambda x: len(x[1]) > 1, all_ips.items()):
            print(f'Внимание: IP {ip} входит в несколько разбиений: {ip_subnetworks}')
            intersections_of_netqorks_was_detected = True
        if not intersections_of_netqorks_was_detected:
            print(f'Пересечения отсутствуют')

