# Assignment 3 - System Report

## Objective

Create an Ansible playbook that reports:

- Hostname
- CPU
- RAM
- Storage
- Operating system

## Target

The playbook targets:

```text
all
```

Therefore it runs against all hosts in the inventory.

## Main Concept - Ansible Facts

The playbook uses:

```yaml
gather_facts: yes
```

Ansible automatically collects system information from the managed nodes. These values are available as Ansible variables.

Examples:

```text
ansible_hostname
ansible_processor_vcpus
ansible_memtotal_mb
ansible_mounts
ansible_distribution
ansible_distribution_version
```

## Module Used

`debug` is used to display the collected information.

## Execution

```bash
ansible-playbook assignment-03-system-report/system_report.yml
```

## Manual verification commands

```bash
ansible all -m shell -a "hostname"
ansible all -m shell -a "nproc"
ansible all -m shell -a "free -h"
ansible all -m shell -a "df -h"
```

## Trainer Explanation

> This playbook collects information from all target instances using Ansible facts. I enable gather_facts, then use Ansible fact variables to display hostname, CPU, RAM, operating system and storage information through the debug module.
