from vagranttoansible import vagranttoansible

# python3 v2a.py -o ../ansible/inventories/hosts
vagranttoansible.DEFAULT_LINE_FORMAT = f"{vagranttoansible.DEFAULT_LINE_FORMAT} ansible_ssh_transfer_method=scp"
# vagranttoansible.DEFAULT_LINE_FORMAT = "[{host}]\n" \
#                                        "{host} " \
#                                        "ansible_user={user} " \
#                                        "ansible_host={ssh_hostname} " \
#                                        "ansible_port={ssh_port} " \
#                                        "ansible_private_key_file={private_file}"
vagranttoansible.cli()
