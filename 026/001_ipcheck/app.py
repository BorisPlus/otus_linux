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
    ipaddress.ip_network('192.168.0.32/28').address_exclude(ipaddress.ip_network('192.168.0.64/26'))
    networks = dict()
    for network_segment_name, network_segment_part in architecture.items():
        networks[network_segment_name] = None
        networks[network_segment_name] = dict()
        for ipaddress_of_network_segment_part, network_segment_part_name in network_segment_part.items():
            network = ipaddress.ip_network(ipaddress_of_network_segment_part)
            wall_network_parent = '.'.join([x for x in ipaddress_of_network_segment_part.split('.')[:3]])
            networks[network_segment_name]['network'] = ipaddress.ip_network(wall_network_parent+'.0/24')
            networks[network_segment_name]['network_hosts'] = [x for x in networks[network_segment_name]['network'].hosts()]

        for ipaddress_of_network_segment_part, network_segment_part_name in network_segment_part.items():
            network = ipaddress.ip_network(ipaddress_of_network_segment_part)
            for host in network.hosts():
                if not host in networks[network_segment_name]['network_hosts']:
                    continue
                networks[network_segment_name]['network_hosts'].remove(host)
        for h in networks[network_segment_name]

    import pprint
    pprint.pprint(networks)
