Ansible Controller Architecture
                    AWS
                     |
             ┌─────────────────┐
             │ Ansible         │
             │ Controller      │
             │ Ubuntu EC2      │
             └────────┬────────┘
                      |
              SSH using .pem key
                      |
       ┌──────────────┼──────────────┐
       ↓              ↓              ↓
    web-01          app-01         app-02
       |                              |
       └──────────────┬───────────────┘
                      ↓
                    db-01

The controller is simply an EC2 instance where Ansible is installed. The target EC2 instances don't need Ansible installed.

Step 1 — Create Controller EC2

Create an EC2 instance with:

OS: Ubuntu
Instance type: t2.micro/t3.micro is sufficient for practice
Key pair: your EC2 key pair
Security Group: allow SSH port 22

You can call it:

ansible-controller

Connect to it:

ssh -i aksh-keypair.pem ubuntu@<CONTROLLER_PUBLIC_IP>
Step 2 — Update Ubuntu

On the controller:

sudo apt update
sudo apt upgrade -y
Step 3 — Install Ansible
sudo apt install ansible -y

Check:

ansible --version

You should get something similar to:

ansible [core ...]
python version = ...
Step 4 — Check SSH

Make sure SSH client exists:

ssh -V

You should get something like:

OpenSSH_...
Step 5 — Copy your EC2 .pem key to the Controller

This is an important part.

Your controller needs the private key so it can SSH into the target EC2 instances.

For example, on the controller:

ls -lh /home/ubuntu/*.pem

You should have:

/home/ubuntu/aksh-keypair.pem

Set the correct permission:

chmod 400 /home/ubuntu/aksh-keypair.pem

or:

chmod 600 /home/ubuntu/aksh-keypair.pem
Step 6 — Test SSH manually

Before involving Ansible, test SSH directly.

For example:

ssh -i /home/ubuntu/aksh-keypair.pem ubuntu@<APP-01-PUBLIC-IP>

If you can log in:

ubuntu@app-01:~$

then SSH authentication is working.

Exit:

exit

Do the same for:

app-02
web-01
db-01
Step 7 — Create Ansible Directory

On the controller:

mkdir -p ~/ansible-assignment
cd ~/ansible-assignment

Create:

mkdir inventory
Step 8 — Create Inventory
nano inventory/hosts

Example:

[webserver]
web-01 ansible_host=<WEB_PUBLIC_IP>

[appserver]
app-01 ansible_host=<APP01_PUBLIC_IP>
app-02 ansible_host=<APP02_PUBLIC_IP>

[dbserver]
db-01 ansible_host=<DB_PUBLIC_IP>

[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=/home/ubuntu/aksh-keypair.pem

In your actual setup, you previously used:

[webserver]
web-01 ansible_host=3.89.245.1

[appserver]
app-01 ansible_host=54.87.51.53
app-02 ansible_host=100.48.100.66

[dbserver]
db-01 ansible_host=18.234.36.85

Those public IPs can change if you stop/terminate and recreate EC2 instances, so always use the current IPs.

Step 9 — Create ansible.cfg

From:

cd ~/ansible-assignment

Create:

nano ansible.cfg

Put:

[defaults]
inventory = inventory/hosts
remote_user = ubuntu
private_key_file = /home/ubuntu/aksh-keypair.pem
host_key_checking = False
interpreter_python = auto_silent

Now Ansible automatically knows:

inventory location
SSH username
private key
host-key behavior
Python interpreter discovery

So you don't need to repeatedly type:

-i inventory/hosts
Step 10 — Verify Configuration

Run:

ansible-config dump --only-changed

You should see something similar to:

DEFAULT_HOST_LIST = ...
DEFAULT_PRIVATE_KEY_FILE = /home/ubuntu/aksh-keypair.pem
DEFAULT_REMOTE_USER = ubuntu
HOST_KEY_CHECKING = False
Step 11 — Test All Servers

Run:

ansible all -m ping

Expected:

app-01 | SUCCESS => {
    "ping": "pong"
}

app-02 | SUCCESS => {
    "ping": "pong"
}

web-01 | SUCCESS => {
    "ping": "pong"
}

db-01 | SUCCESS => {
    "ping": "pong"
}

At this point your controller is ready.

Step 12 — Test Individual Groups
Web server
ansible webserver -m ping
Application servers
ansible appserver -m ping
Database server
ansible dbserver -m ping
All servers
ansible all -m ping
Step 13 — Test an Ansible Command

For example:

ansible all -m shell -a "hostname"

You should get the hostname of every server.

You can also run:

ansible all -m shell -a "uptime"

or:

ansible all -m shell -a "df -h"
How the Authentication Works

The important part to understand for interviews is:

Controller
   |
   | SSH
   | ubuntu
   | aksh-keypair.pem
   ↓
EC2 Instance

The EC2 instance has the corresponding public key in:

/home/ubuntu/.ssh/authorized_keys

The controller has the private key:

/home/ubuntu/aksh-keypair.pem

Ansible uses SSH to authenticate.

No Ansible agent is required

You don't install Ansible on:

web-01
app-01
app-02
db-01

You install Ansible only on:

ansible-controller

The target machines generally need:

SSH access
Python for most Ansible modules
Final Controller Structure

Your controller should eventually look like:

/home/ubuntu/
│
├── aksh-keypair.pem
│
└── ansible-assignment/
    │
    ├── ansible.cfg
    │
    ├── inventory/
    │   └── hosts
    │
    ├── assignment-01-...
    ├── assignment-02-server-utilization/
    ├── assignment-03-tomcat/
    ├── assignment-04-ansible-configuration/
    ├── assignment-05-new-version-deployment/
    ├── assignment-06-ansible-vault/
    └── assignment-07-...
