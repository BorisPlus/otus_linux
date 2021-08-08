#  pip3 install ipaddress
import ipaddress

if __name__ == '__main__':

    nw = ipaddress.ip_network('192.168.1.192/26')
    print(nw.network_address)
    for h in nw.hosts():
        print(h)
    print(nw.broadcast_address)
    print(nw.num_addresses)
    print(len(set(nw.hosts())))

