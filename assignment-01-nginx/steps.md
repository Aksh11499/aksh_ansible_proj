# Assignment 01 - Nginx Installation and Application Deployment Using Ansible

---

## 1. Assignment Objective

Install and configure Nginx on an Ubuntu web server using Ansible.

The assignment includes:

- Creating AWS EC2 instances
- Setting up an Ansible Controller
- Setting up a Web Server
- Configuring SSH connectivity
- Creating an Ansible inventory
- Testing Ansible connectivity
- Installing Nginx
- Changing Nginx port from 80 to 8081
- Deploying an HTML application
- Restarting Nginx
- Verifying Nginx
- Verifying port 8081
- Testing the application
- Accessing the application from a browser

---

# 2. Environment

Two EC2 instances were used.

## Ansible Controller

| Parameter | Value |
|---|---|
| Role | Ansible Controller |
| OS | Ubuntu |
| Private IP | 172.31.18.103 |
| User | ubuntu |
| Key Pair | aksh-keypair.pem |

## Web Server

| Parameter | Value |
|---|---|
| Hostname | web-01 |
| Role | Web Server |
| OS | Ubuntu |
| Private IP | 172.31.16.43 |
| Current Public IP | 13.220.177.221 |
| User | ubuntu |
| Web Server | Nginx |
| Application Port | 8081 |

---

# 3. Architecture

```text
                         Internet
                            |
                            |
                    Public IP :8081
                            |
                            v
                 +-------------------+
                 |     AWS EC2       |
                 |      web-01       |
                 |                   |
                 |  Nginx :8081      |
                 |  index.html       |
                 +-------------------+
                            ^
                            |
                       SSH / Ansible
                            |
                            |
                 +-------------------+
                 |     AWS EC2       |
                 | Ansible Controller|
                 |                   |
                 |  Ansible          |
                 |  Inventory        |
                 |  Playbook         |
                 +-------------------+
