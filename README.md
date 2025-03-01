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

## Build a Ubuntu 24.04 VM

Launch the Ubuntu VM using the cloud-init config which prepares the VM for running ansible.

```
multipass launch 24.04 -n sftp-server --cloud-init .\wsl-cloud-init.yaml
```

## Install/Configure Python

Make sure you have Python, I used 3.12

```
winget install --id=Python.Python.3.12  -e
```

Create a python virtual environment (I'm using powershell)

```
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

## Install Ansible

Use pip

```
pip install ansible
```

# Run SFTP Server Playbook

First get the address for the VM 