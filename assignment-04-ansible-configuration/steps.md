# Assignment 4 - Custom Ansible Inventory and Configuration

## Objective

Create a custom Ansible inventory file and ansible.cfg file containing:

- Inventory location
- Remote user
- SSH private key
- Host key checking configuration

## Environment

Ansible Controller:
- Ubuntu EC2 instance

Managed Servers:
- web-01
- app-01
- app-02
- db-01

## Directory Structure

assignment-04-ansible-configuration/
├── ansible.cfg
├── hosts.ini
├── outputs/
└── STEPS.md

## Step 1 - Create Assignment Directory

```bash
mkdir -p ~/ansible-assignment/assignment-04-ansible-configuration/outputs
cd ~/ansible-assignment/assignment-04-ansible-configuration
