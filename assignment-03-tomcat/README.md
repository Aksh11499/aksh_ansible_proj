# Assignment 3 - Tomcat Installation and Configuration

## Objective

Install Java and Apache Tomcat on the application servers using Ansible.

The Tomcat application servers are:

- app-01
- app-02

Ansible Controller:

- ansible_controller

## Infrastructure

| Server | Role | Public IP |
|---|---|---|
| ansible_controller | Ansible Controller | 98.81.153.139 |
| web-01 | Web Server | 3.89.245.1 |
| app-01 | Application Server | 54.87.51.53 |
| app-02 | Application Server | 100.48.100.66 |
| db-01 | Database Server | 18.234.36.85 |

> Public IP addresses may change when EC2 instances are stopped and started. The inventory file contains the currently active IP addresses.

## Assignment Requirement

The playbook performs the following tasks:

1. Install Java.
2. Create the Tomcat group.
3. Create the Tomcat user.
4. Create the Tomcat installation directory.
5. Download Apache Tomcat.
6. Extract Tomcat.
7. Set the required ownership and permissions.
8. Configure Tomcat.
9. Change the Tomcat port from 8080 to 9090.
10. Create a systemd service for Tomcat.
11. Reload systemd.
12. Start Tomcat.
13. Enable Tomcat to start automatically after reboot.
14. Wait for port 9090.
15. Verify the Tomcat service.

## Directory Structure

```text
assignment-03-tomcat/
├── README.md
├── STEPS.md
├── tomcat_install.yml
├── tomcat.service
└── outputs/
    ├── tomcat-install-output.txt
    └── tomcat-verification.txt
