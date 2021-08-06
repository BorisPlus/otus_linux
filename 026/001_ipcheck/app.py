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
    nw = dict()
    for network_segment_name, network_segment_part in architecture.items():
        nw[network_segment_name] = dict(reserved=set())
        for ipaddress_of_network_segment_part, network_segment_part_name in network_segment_part.items():
            network = ipaddress.ip_network(ipaddress_of_network_segment_part)
            nw[network_segment_name]['subnet'] = network
            nw[network_segment_name] = (nw[network_segment_name]['reserved']).union(set( network.hosts()))

    for nw_name, nw_ip_addresses in nw.items():
        print(f'{nw_name} belongs to {nw_ip_addresses}')
