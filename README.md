# Ansible Assignments

This Git repository contains all 4 Ansible class assignments in separate folders.

## Project Structure

```text
ansible-assignments/
├── README.md
├── ansible.cfg
├── .gitignore
│
├── inventory/
│   └── hosts.ini
│
├── assignment-01-nginx/
│   ├── README.md
│   ├── nginx.yml
│   └── files/
│       └── index.html
│
├── assignment-02-tomcat/
│   ├── README.md
│   └── tomcat.yml
│
├── assignment-03-system-report/
│   ├── README.md
│   └── system_report.yml
│
└── assignment-04-inventory/
    ├── README.md
    └── hosts.ini
```

## Prerequisites

- Ansible installed on the control node
- SSH access from control node to managed nodes
- Ubuntu/Debian target servers for the `apt` examples
- A valid SSH private key
- Replace all placeholder IP addresses before running

## Initial setup

```bash
cd ansible-assignments
ansible --version
ansible-inventory -i inventory/hosts.ini --graph
ansible all -i inventory/hosts.ini -m ping
```

If the ping succeeds, the control node can communicate with the managed nodes.

## Run Assignment 1

```bash
ansible-playbook assignment-01-nginx/nginx.yml
```

## Run Assignment 2

```bash
ansible-playbook assignment-02-tomcat/tomcat.yml
```

## Run Assignment 3

```bash
ansible-playbook assignment-03-system-report/system_report.yml
```

## Assignment 4

Assignment 4 is about creating and understanding a custom inventory and Ansible configuration. The example inventory is in:

```text
assignment-04-inventory/hosts.ini
```

## Important Security Rule

Never commit `.pem`, `.key`, or other private SSH keys to Git.

The `.gitignore` file is included to help prevent this.
