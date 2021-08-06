#  pip3 install ipaddress
import ipaddress

if __name__ == '__main__':
    architecture = {
        'Сеть office1': {
            '192.168.2.0/26': 'dev',
            '192.168.2.64/26': 'test servers',
            '192.168.2.128/26': 'managers',
            '192.168.2.192/26': 'office hardware'},
        'Сеть office2': {
            '192.168.1.0/25': 'dev',
            '192.168.1.128/26': 'test servers',
            '192.168.1.192/26': 'office hardware'},
        'Сеть central': {
            '192.168.0.0/28': 'directors',
            '192.168.0.32/28': 'office hardware',
            '192.168.0.64/26': 'wifi'
        }
    }
    hosts = dict()
    for network_segment_name, network_segment_part in architecture.items():
        print(network_segment_name)
        for ipaddress_of_network_segment_part, network_segment_part_name in network_segment_part.items():
            print('\t', ipaddress_of_network_segment_part, network_segment_part_name)
            network = ipaddress.ip_network(ipaddress_of_network_segment_part)
            for host in network.hosts():
                if host not in hosts:
                    hosts[host] = set()
                hosts[host].add(f'{network_segment_name}: {network_segment_part_name}')
                print('\t', '\t', host)

    intersections_of_netqorks_was_detected = False
    for host_ip, host_networks in filter(lambda x: len(x[1]) > 1, hosts.items()):
        print(f'Alarm: IP {host_ip} belongs to some of view networks: {host_networks}')
        intersections_of_netqorks_was_detected = True
    if not intersections_of_netqorks_was_detected:
        print(f'There are no intersections of networks')