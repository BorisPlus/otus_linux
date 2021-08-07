#  pip3 install ipaddress
import ipaddress
import sys
import os

if __name__ == '__main__':
    # python3 ./026/001_ipcheck/app.py > ./026/001_ipcheck/report.txt
    # python3 ./026/001_ipcheck/app.py md > ./026/001_ipcheck/table.md
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
    # nw = ipaddress.ip_network('192.168.0.128/25')
    # print(nw.network_address)
    # for h in nw.hosts():
    #     print(h)
    # print(nw.broadcast_address)
    # print(nw.num_addresses)
    # print(len(set(nw.hosts())))
    # print(pow(2,32-25))
    # exit(0)
    networks = dict()
    for segment_name, subnetworks in architecture.items():
        networks[segment_name] = dict()
        for subnetwork_ip, subnetwork_name in subnetworks.items():
            subnetwork_obj = ipaddress.ip_network(subnetwork_ip)

            global_network_ip_parent = '.'.join([x for x in subnetwork_ip.split('.')[:3]])
            global_network_ip = global_network_ip_parent + '.0/24'

            networks[segment_name]['global_network_ip_parent'] = global_network_ip_parent
            networks[segment_name]['global_network_ip'] = global_network_ip

            global_network_obj = ipaddress.ip_network(global_network_ip)
            global_network_ip_addresses = set(global_network_obj.hosts())
            global_network_ip_addresses.add(global_network_obj.network_address)
            global_network_ip_addresses.add(global_network_obj.broadcast_address)

            networks[segment_name]['candidates_undefined_ip'] = global_network_ip_addresses
            break
    #
    for segment_name, subnetworks in architecture.items():
        for subnetwork_ip, subnetwork_name in subnetworks.items():

            subnetwork_obj = ipaddress.ip_network(subnetwork_ip)
            subnetwork_ip_addresses = set(subnetwork_obj.hosts())
            subnetwork_ip_addresses.add(subnetwork_obj.network_address)
            subnetwork_ip_addresses.add(subnetwork_obj.broadcast_address)

            for ip_address in subnetwork_ip_addresses:
                if ip_address in networks[segment_name]['candidates_undefined_ip']:
                    networks[segment_name]['candidates_undefined_ip'].remove(ip_address)

        networks[segment_name]['undefined_ipaddresses'] = networks[segment_name]['candidates_undefined_ip']
        del networks[segment_name]['candidates_undefined_ip']
    #
    for segment_name in networks:
        start_ipaddress_obj = None
        last_ipaddress_obj = None
        networks[segment_name]["undefined_subnetworks"] = set()

        for last_number in range(0, 256):
            current_ipaddress_obj = ipaddress.ip_address(
                networks[segment_name]['global_network_ip_parent'] + '.' + str(last_number))
            if start_ipaddress_obj is None and current_ipaddress_obj in networks[segment_name]['undefined_ipaddresses']:
                start_ipaddress_obj = current_ipaddress_obj
                last_ipaddress_obj = current_ipaddress_obj
            if start_ipaddress_obj and current_ipaddress_obj in networks[segment_name]['undefined_ipaddresses']:
                last_ipaddress_obj = current_ipaddress_obj
            if current_ipaddress_obj not in networks[segment_name]['undefined_ipaddresses'] and start_ipaddress_obj:
                address_range = ipaddress.summarize_address_range(start_ipaddress_obj, last_ipaddress_obj)

                for undefined_subnetwork in address_range:
                    networks[segment_name]["undefined_subnetworks"].add(undefined_subnetwork)

                start_ipaddress_obj = None
                last_ipaddress_obj = None

        if start_ipaddress_obj and last_ipaddress_obj:
            address_range = ipaddress.summarize_address_range(start_ipaddress_obj, last_ipaddress_obj)
            for undefined_subnetwork in address_range:
                networks[segment_name]["undefined_subnetworks"].add(undefined_subnetwork)

        for undefined_nw_ip in networks[segment_name]["undefined_subnetworks"]:
            networks[segment_name][str(undefined_nw_ip)] = 'undefined'
        for nw_ip, nw_name in architecture[segment_name].items():
            networks[segment_name][nw_ip] = nw_name
    #     # del networks[network_segment_name]["undefined_subnetworks"]
    #     # del networks[network_segment_name]["undefined_subnet_hosts"]

    if len(sys.argv) == 1:
        print(
            (' '.join([a for a in sys.argv])).replace(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), '.'))
        print()
        import pprint

        pprint.pprint(networks)
        #

        for network in networks:
            for k in (
                    'global_network_ip',
                    "undefined_ipaddresses",
                    "undefined_subnetworks",
                    "global_network_ip_parent"
            ):
                if k in networks[network]:
                    del networks[network][k]

        for network, subnetwork in networks.items():
            network_hosts = set()
            for subnetwork_ip, subnetwork_name in subnetwork.items():
                subnetwork_obj = ipaddress.ip_network(subnetwork_ip)
                subnetwork_hosts = subnetwork_obj.hosts()
                # print(subnetwork_ip)
                # print('\t', subnetwork_obj.network_address)
                network_hosts.add(subnetwork_obj.network_address)
                for h in subnetwork_hosts:
                    # print('\t', h)
                    network_hosts.add(h)
                # if subnetwork_obj.broadcast_address not in network_hosts:
                #     print('\t', subnetwork_obj.broadcast_address)
                network_hosts.add(subnetwork_obj.broadcast_address)
                # print()
            if len(network_hosts) != 256:
                print(f'Network {network} has {len(network_hosts)}, it is not 256 subnetworks distribution')

    if len(sys.argv) == 2 and sys.argv[1] == 'md':
        for network in networks:
            for k in (
                    'global_network_ip',
                    "undefined_ipaddresses",
                    "undefined_subnetworks",
                    "global_network_ip_parent"
            ):
                if k in networks[network]:
                    del networks[network][k]

        print(f'Сегмент сети | его часть | наименование | число IP-адресов')
        print(f'--- | --- | --- | ---')
        for network_name, subnetwork in networks.items():
            for subnetwork_ip, subnetwork_name in subnetwork.items():
                network = ipaddress.ip_network(subnetwork_ip)
                hosts = set(network.hosts())
                hosts.add(network.network_address)
                hosts.add(network.broadcast_address)
                print(
                    f'{network_name} | {subnetwork_ip} | {subnetwork_name} | {len(hosts)} '
                )

    for network in networks:
        for k in (
                'global_network_ip',
                "undefined_ipaddresses",
                "undefined_subnetworks",
                "global_network_ip_parent"
        ):
            if k in networks[network]:
                del networks[network][k]
    import json

    for d in (os.path.basename(os.path.dirname(__file__)), '002_ipcheck', '003_ipcheck', '004_ipcheck'):
        with open(os.path.join(os.path.dirname(os.path.dirname(__file__)), d, 'networks.py'), 'w') as f:
            f.write('networks = {}'.format(json.dumps(networks, ensure_ascii=False, indent=3)))
