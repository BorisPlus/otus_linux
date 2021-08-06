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
    broadcasts = dict()
    for network_segment_name, network_segment_part in architecture.items():
        for ipaddress_of_network_segment_part, network_segment_part_name in network_segment_part.items():
            network = ipaddress.ip_network(ipaddress_of_network_segment_part)
            # print()
            if network_segment_name not in broadcasts:
                broadcasts[f'{network_segment_name}'] = dict()
            broadcasts[f'{network_segment_name}'][f'{network_segment_part_name} ({ipaddress_of_network_segment_part})'] = network.broadcast_address

    for network_segment_name, network_segment_part in broadcasts.items():
        for network_segment_part_name, ipaddress_of_broadcast in network_segment_part.items():
            print(f'В сегменте сети "{network_segment_name}" его часть "{network_segment_part_name}" имеет broadcast-IP "{ipaddress_of_broadcast}"')

    if 1 :
        print(f'Сегмент сети | его часть | broadcast-IP')
        print(f'--- | --- | ---')
        for network_segment_name, network_segment_part in broadcasts.items():
            for network_segment_part_name, ipaddress_of_broadcast in network_segment_part.items():
                print(f'{network_segment_name} | {network_segment_part_name} | {ipaddress_of_broadcast} ')
