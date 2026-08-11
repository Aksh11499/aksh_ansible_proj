# Assignment 4 - Custom Inventory and Ansible Configuration

## Objective

Create and understand a custom Ansible inventory and configuration.

## Inventory groups

```text
webserver
├── web-01
└── web-02

appserver
├── app-01
└── app-02

dbserver
└── db-01
```

## Files

`hosts.ini` contains:

- Server groups
- Hostnames
- Target IP addresses
- SSH user
- SSH private-key path

The main project configuration is in the root `ansible.cfg`.

## Example inventory

Replace the placeholders:

```ini
[webserver]
web-01 ansible_host=<WEB01-IP>
web-02 ansible_host=<WEB02-IP>
```

with actual server IP addresses.

## Test the inventory

From the repository root:

```bash
ansible-inventory --graph
ansible all -m ping
ansible webserver -m ping
ansible appserver -m ping
ansible dbserver -m ping
```

## Why use groups?

Groups allow targeted automation.

For example:

```bash
ansible webserver -m ping
```

only targets web servers.

## Trainer Explanation

> My inventory is divided into webserver, appserver and dbserver groups. Each host has an Ansible name and an actual IP address using ansible_host. I also define the SSH user and private-key path. This allows me to target individual groups instead of running every operation on every server.
