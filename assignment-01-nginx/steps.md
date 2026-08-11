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


Step 1 — Create project

On the Ansible controller:

mkdir -p ~/ansible-assignment
cd ~/ansible-assignment

Create directories:

mkdir -p assignment-01-nginx
Step 2 — Create inventory

We created a common inventory:

inventory/
└── hosts

Example:

[webserver]
web-01 ansible_host=<WEB_IP>

[appserver]
app-01 ansible_host=<APP1_IP>
app-02 ansible_host=<APP2_IP>

[dbserver]
db-01 ansible_host=<DB_IP>

[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=/home/ubuntu/aksh-keypair.pem
Step 3 — Test connectivity
ansible all -i inventory/hosts -m ping

Expected:

SUCCESS => ping: pong
Step 4 — Create HTML application

Inside Assignment 1:

cd assignment-01-nginx
nano index.html

Example:

<html>
<head>
    <title>Ansible Assignment</title>
</head>
<body>
    <h1>Nginx Application Deployed Successfully</h1>
</body>
</html>
Step 5 — Create Nginx playbook

Create:

nano nginx.yml

The playbook performs:

Install Nginx
      ↓
Change port 80 → 8081
      ↓
Change IPv6 80 → 8081
      ↓
Copy index.html
      ↓
nginx -t
      ↓
Restart Nginx
      ↓
Wait for 8081
      ↓
HTTP health check

The PDF's playbook follows exactly this flow.

Step 6 — Syntax check
ansible-playbook -i inventory/hosts assignment-01-nginx/nginx.yml --syntax-check

Expected:

playbook: nginx.yml
Step 7 — Execute
ansible-playbook -i inventory/hosts assignment-01-nginx/nginx.yml
Step 8 — Verify Nginx
ansible webserver -i inventory/hosts -m shell -a "systemctl status nginx --no-pager" --become
Step 9 — Verify port
ansible webserver -i inventory/hosts -m shell -a "ss -lntp | grep 8081" --become
Step 10 — Verify application
ansible webserver -i inventory/hosts -m uri -a "url=http://127.0.0.1:8081 status_code=200"
