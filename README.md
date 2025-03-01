# SFTP_Service
A generic debian based SFTP file delivery service

# Prerequisites

I used my local Windows 11 installation with Hyper-V enabled to provision the Ubuntu 24.04 LTS VM which hosts the SFTP delivery service. The Ansible playbook provided here should work with any Ubuntu 24.04 LTS cloud-init enabled VM image once the included cloud-init config is applied. The VM can be hosted locally or in a cloud, simply provide the correct connection information when running the playbook.

## Windows Local Instructions

Install `multipass` from Canonical

```
winget install -e --id Canonical.Multipass
```

Check the install and version

```
multipass version
```

You should see output like the following:

```
multipass   1.14.1+win
multipassd  1.14.1+win

#########################################################################################
Multipass 1.15.0 release
Clone, bridging on QEMU/Linux, Updated GUI, MSI installer.

Go here for more information: https://github.com/canonical/multipass/releases/tag/v1.15.0
#########################################################################################
```

## Build a Ubuntu 24.04 VM (in WSL)

Launch the Ubuntu VM using the cloud-init config which prepares the VM for running ansible. I had to bridge with my main system network interface.

```
multipass.exe set local.bridged-network="Ethernet 2"
multipass.exe launch 24.04 -n sftp-server --cloud-init cloud-init.yaml --bridged
```

## Install Ansible

Create a python virtual environment

```
python3 -m venv .venv && source .venv/bin/activate
```

Use pip

```
pip install ansible
```

## Validate Ansible Connectivity

Get the new VM IP

```
multipass.exe list
Name                    State             IPv4             Image
sftp-server             Running           172.21.170.147   Ubuntu 24.04 LTS
                                          192.168.6.29
```

Run an ansible "ping" Check

```
ansible -u ansible --private-key id_ed25519 all -i 192.168.6.29, -m ping
192.168.6.29 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

# Create Customer/client Keypairs

The private key will be distributed to clients and stored in a password safe or vault.

Create a customer keypair

```
ssh-keygen -t ed25519
```

Add each customer's public key to the `sftp_users.yml` file

# Run SFTP Server Playbook

Use the IP for the VM you created earlier

```
ansible-playbook -u ansible --private-key id_ed25519 -i 192.168.6.29, playbook.yml
```