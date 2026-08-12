Objective

Install and configure Apache Tomcat on the application servers using Ansible.

For your setup, Assignment 3 uses:

Ansible Controller
       |
       +---- app-01
       |
       +---- app-02

Your web-01 and db-01 are not required for the Tomcat installation itself.

Step 1 – Navigate to the assignment
cd ~/ansible-assignment/assignment-03-tomcat

Check the files:

ls -lah

Expected structure:

assignment-03-tomcat/
├── README.md
├── tomcat_install.yml
└── output/
Step 2 – Verify the inventory

Your common inventory is:

cat ../inventory/hosts

It should contain:

[webserver]
web-01 ansible_host=3.89.245.1

[appserver]
app-01 ansible_host=54.87.51.53
app-02 ansible_host=100.48.100.66

[dbserver]
db-01 ansible_host=18.234.36.85

[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=/home/ubuntu/aksh-keypair.pem
Step 3 – Test the application servers

Run:

ansible appserver -i ../inventory/hosts -m ping

Expected:

app-01 | SUCCESS
app-02 | SUCCESS
Step 4 – Check Java

Before installing Tomcat, check Java:

ansible appserver -i ../inventory/hosts -m shell -a "java -version"

Initially, you received:

java: not found

So Java needed to be installed.

Step 5 – Create the Tomcat playbook

Open:

nano tomcat_install.yml

The playbook performs the following:

Installs Java
Creates the tomcat user
Downloads Tomcat
Extracts Tomcat
Creates the required directories
Sets ownership and permissions
Creates the systemd service
Starts Tomcat
Enables Tomcat at boot
Verifies the service

Your playbook should target:

hosts: appserver

because both app-01 and app-02 are application servers.

Step 6 – Syntax check

Before executing:

ansible-playbook -i ../inventory/hosts tomcat_install.yml --syntax-check

Expected:

playbook: tomcat_install.yml

You successfully reached this stage earlier.

Step 7 – Run the playbook

Execute:

ansible-playbook -i ../inventory/hosts tomcat_install.yml

The playbook should execute against both:

app-01
app-02

At the end you should see something similar to:

PLAY RECAP
app-01 : ok=16 changed=11 unreachable=0 failed=0
app-02 : ok=16 changed=10 unreachable=0 failed=0

You already achieved this successfully.

Step 8 – Verify Java

After installation:

ansible appserver -i ../inventory/hosts -m shell -a "java -version"

You previously received:

openjdk version "25.0.3"

for both application servers.

Step 9 – Verify Tomcat directory

Run:

ansible appserver -i ../inventory/hosts -m shell -a "ls -ld /opt/tomcat" --become

Expected:

/opt/tomcat
Step 10 – Verify Tomcat service

Run:

ansible appserver -i ../inventory/hosts -m shell \
-a "systemctl status tomcat --no-pager" --become

You should see:

Active: active (running)

This confirms Tomcat is running.

Step 11 – Verify Tomcat port

Your Tomcat was configured to use port 9090.

Run:

ansible appserver -i ../inventory/hosts -m shell \
-a "ss -lntp | grep 9090" --become

Expected:

LISTEN ... *:9090 ... users:(("java",...))

You successfully verified this earlier on both servers.

Step 12 – Verify Tomcat webapps

Because /opt/tomcat belongs to the tomcat user, normal ubuntu access may give:

Permission denied

So use --become:

ansible appserver -i ../inventory/hosts -m shell \
-a "ls -lh /opt/tomcat/webapps/" --become

You should see directories such as:

ROOT
docs
examples
host-manager
manager
Step 13 – Save output

Create the output file:

ansible-playbook -i ../inventory/hosts tomcat_install.yml \
| tee output/tomcat-install-output.txt

Then verify:

cat output/tomcat-install-output.txt
Step 14 – Final directory structure

Your Assignment 3 should look like:

assignment-03-tomcat/
│
├── README.md
├── tomcat_install.yml
│
└── output/
    └── tomcat-install-output.txt
Final Verification Checklist

Run these one by one:

1. Ping
ansible appserver -i ../inventory/hosts -m ping
2. Java
ansible appserver -i ../inventory/hosts -m shell -a "java -version"
3. Tomcat directory
ansible appserver -i ../inventory/hosts -m shell \
-a "ls -ld /opt/tomcat" --become
4. Tomcat service
ansible appserver -i ../inventory/hosts -m shell \
-a "systemctl is-active tomcat" --become

Expected:

active
5. Tomcat port
ansible appserver -i ../inventory/hosts -m shell \
-a "ss -lntp | grep 9090" --become
6. Webapps
ansible appserver -i ../inventory/hosts -m shell \
-a "ls -lh /opt/tomcat/webapps/" --become
