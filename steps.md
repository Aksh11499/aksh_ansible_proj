Step 1 — Verify application servers
ansible appserver -i inventory/hosts -m ping
Step 2 — Check Java

Initially we ran:

ansible appserver -i inventory/hosts -m shell -a "java -version"

and got:

java: not found

That confirmed Java needed to be installed.

Step 3 — Check Ubuntu version
ansible appserver -i inventory/hosts -m shell -a "lsb_release -a"

We verified the servers were Ubuntu.

Step 4 — Create Tomcat playbook
mkdir -p assignment-03-tomcat
nano assignment-03-tomcat/tomcat_install.yml

The playbook performs:

Update apt
   ↓
Install Java
   ↓
Create tomcat group
   ↓
Create tomcat user
   ↓
Create /opt/tomcat
   ↓
Download Tomcat
   ↓
Extract Tomcat
   ↓
Set permissions
   ↓
Change port
   ↓
Create systemd service
   ↓
Start Tomcat
Step 5 — Syntax check
ansible-playbook \
-i inventory/hosts \
assignment-03-tomcat/tomcat_install.yml \
--syntax-check

We got:

playbook: assignment-03-tomcat/tomcat_install.yml
Step 6 — Execute
ansible-playbook \
-i inventory/hosts \
assignment-03-tomcat/tomcat_install.yml

We eventually got:

app-01 : ok=16 changed=11 failed=0
app-02 : ok=16 changed=10 failed=0
Step 7 — Verify Java
ansible appserver -i inventory/hosts -m shell -a "java -version"

We verified Java was installed on both application servers.

Step 8 — Verify Tomcat
ansible appserver -i inventory/hosts \
-m shell \
-a "systemctl status tomcat --no-pager" \
--become
Step 9 — Verify port 9090
ansible appserver -i inventory/hosts \
-m shell \
-a "ss -lntp | grep 9090" \
--become

We verified Tomcat was listening on:

*:9090
