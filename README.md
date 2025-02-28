# SFTP_Service
A generic debian based SFTP file delivery service

# Prerequisites

I used my local Windows 11 installation with Hyper-V to provision the Ubuntu 24.04 LTS VM which hosts the SFTP delivery service. The Ansible playbook provided here should work with any Ubuntu 24.04 LTS cloud-init enabled VM image once the included cloud-init config is applied. The VM can be hosted locally or in a cloud, simply provide the correct connection information when running the playbook.

## Windows Local Instructions

Install `vagrant`

```
winget install --id=Hashicorp.Vagrant  -e
```

Create and initialize the Vagrantfile

```

```