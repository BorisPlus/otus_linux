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
        for ipaddress_of_network_segment_part, network_segment_part_name in network_segment_part.items():
            network = ipaddress.ip_network(ipaddress_of_network_segment_part)
            #  # f'"{len(list(network.hosts()))}" '
            num_addresses = '%s' % network.num_addresses
            # f'\t'
            print(
                f'В сегменте сети "{str(network_segment_name)}" его часть "{str(network_segment_part_name)}" '
                f'("{ipaddress_of_network_segment_part}") содержит '
                f'"{num_addresses}"'
                f' адрес'
                f'{"ов" if str(len(list(network.hosts())))[-1] in ("0", "4", "5", "6", "7", "8", "9") else ""}'
                f'{"а" if str(len(list(network.hosts())))[-1] in ("2", "3") else ""}'
                #
            )
        #
        # if 1:
        #     print(f'Сегмент сети | его часть | число IP-адресов')
        #     print(f'--- | --- | ---')
        #     for network_segment_name, network_segment_part in architecture.items():
        #         for ipaddress_of_network_segment_part, network_segment_part_name in network_segment_part.items():
        #             network = ipaddress.ip_network(ipaddress_of_network_segment_part)
        #             print(
        #                 f'{network_segment_name} | {network_segment_part_name} ({ipaddress_of_network_segment_part}) | {len(list(network.hosts()))} '
        #             )
