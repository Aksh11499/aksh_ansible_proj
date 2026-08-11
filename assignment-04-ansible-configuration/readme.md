Step 2 - Create ansible.cfg

The configuration file contains:

[defaults]
inventory = hosts.ini
host_key_checking = False
remote_user = ubuntu
private_key_file = /home/ubuntu/aksh-keypair.pem
interpreter_python = auto_silent
Step 3 - Create hosts.ini

The inventory contains the following server groups:

[webserver]
web-01 ansible_host=3.89.245.1

[appserver]
app-01 ansible_host=54.87.51.53
app-02 ansible_host=100.48.100.66

[dbserver]
db-01 ansible_host=18.234.36.85
Step 4 - Verify Ansible Configuration

Command:

ansible-config dump --only-changed

Verified:

Custom inventory file
Ubuntu remote user
SSH private key
Host key checking disabled
Step 5 - Verify Inventory

Command:

ansible-inventory --graph

Expected groups:

webserver
appserver
dbserver
Step 6 - Test Connectivity

Command:

ansible all -m ping

Result:

app-01 | SUCCESS
app-02 | SUCCESS
web-01 | SUCCESS
db-01 | SUCCESS
Step 7 - Save Evidence

Inventory:

ansible-inventory --graph | tee outputs/inventory-graph.txt

Connectivity:

ansible all -m ping | tee outputs/ping-test.txt

Configuration:

ansible-config dump --only-changed | tee outputs/ansible-config.txt
Result

Assignment 4 was successfully completed.

A custom inventory file and ansible.cfg were created and verified.

All four managed EC2 instances successfully responded to the Ansible ping module.


Save:

```text
Ctrl + O
Enter
Ctrl + X
Step 5 — Create README

Then:

nano README.md

Paste:

# Assignment 4 - Custom Ansible Inventory and Configuration

## Objective

Create a custom Ansible inventory file and ansible.cfg file with the required remote user and private SSH key.

## Files

- `ansible.cfg` - Ansible configuration
- `hosts.ini` - Custom inventory
- `STEPS.md` - Complete execution steps
- `outputs/` - Execution evidence

## Servers

| Group | Server |
|---|---|
| webserver | web-01 |
| appserver | app-01 |
| appserver | app-02 |
| dbserver | db-01 |

## Configuration

The custom `ansible.cfg` defines:

- Inventory file
- Remote user: ubuntu
- SSH private key
- Host key checking
- Python interpreter discovery

## Verification

### Inventory

```bash
ansible-inventory --graph
Connectivity
ansible all -m ping
Configuration
ansible-config dump --only-changed
Result

All four managed servers were successfully connected using Ansible.


Save and exit.

---

### Final Assignment 4 structure

Run:

```bash
tree assignment-04-ansible-configuration

If tree isn't installed:

find assignment-04-ansible-configuration -type f

You should have:

assignment-04-ansible-configuration/
├── ansible.cfg
├── hosts.ini
├── README.md
├── STEPS.md
└── outputs/
    ├── ansible-config.txt
    ├── inventory-graph.txt
    └── ping-test.txt
