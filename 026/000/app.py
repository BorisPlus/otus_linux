#  pip3 install ipaddress
import ipaddress

if __name__ == '__main__':

    nw = ipaddress.ip_network('192.168.0.0/16')
    print(nw.network_address)
    for h in nw.hosts():
        print(h)
    print('broadcast_address', nw.broadcast_address)
    print('network_address', nw.network_address)
    print(nw.num_addresses)
    print(len(set(nw.hosts())))

