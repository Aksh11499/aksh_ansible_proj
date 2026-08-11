# Assignment 2 - Server Utilization Report

## Objective

Generate a server utilization report using Ansible containing:

- Hostname
- CPU Utilization
- RAM Utilization
- Storage Utilization

The assignment was implemented using an Ansible playbook and executed against the appserver group.

---

# 1. Environment

## Ansible Controller

Hostname:

    ip-172-31-18-103

The controller is the machine from which Ansible commands and playbooks are executed.

## Managed Server

Inventory hostname:

    web-01

Public IP:

    13.220.177.221

Private IP:

    172.31.16.43

For this assignment, the existing web-01 server was also added to the appserver group.

No additional EC2 instance was created because the existing server could be reused.

---

# 2. Inventory Configuration

The existing inventory was kept so that Assignment 1 would continue to work.

File:

    inventory/hosts

The inventory contains:

    [webserver]
    web-01 ansible_host=13.220.177.221

    [appserver]
    web-01 ansible_host=13.220.177.221

    [all:vars]
    ansible_user=ubuntu
    ansible_ssh_private_key_file=/home/ubuntu/aksh-keypair.pem

The same server belongs to both groups.

Assignment 1 uses:

    webserver

Assignment 2 uses:

    appserver

---

# 3. Verify Inventory

The inventory was checked using:

    ansible-inventory -i inventory/hosts --graph

The output showed:

    @all:
      |--@ungrouped:
      |--@webserver:
      |  |--web-01
      |--@appserver:
      |  |--web-01

This confirmed that web-01 belongs to both webserver and appserver groups.

---

# 4. Test Ansible Connectivity

The webserver group was tested:

    ansible webserver -i inventory/hosts -m ping

Result:

    web-01 | SUCCESS
    "ping": "pong"

The appserver group was also tested:

    ansible appserver -i inventory/hosts -m ping

Result:

    web-01 | SUCCESS
    "ping": "pong"

This confirmed that the Ansible controller could successfully connect to the managed server.

---

# 5. Create Assignment Directory

The Assignment 2 directory was created using:

    mkdir -p assignment-02-server-utilization/outputs

Directory structure:

    assignment-02-server-utilization/
    └── outputs/

---

# 6. Create the Ansible Playbook

Playbook:

    assignment-02-server-utilization/server_report.yml

The playbook was created to collect:

- Hostname
- CPU utilization
- RAM utilization
- Storage utilization

The playbook targets:

    hosts: appserver

It also uses:

    become: true
    gather_facts: true

---

# 7. CPU Utilization

The playbook uses:

    top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}'

This collects CPU utilization from the target server.

The result is stored using:

    register: cpu_usage

The output is later accessed using:

    cpu_usage.stdout

---

# 8. RAM Utilization

The playbook uses:

    free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2}'

The command calculates the percentage of used memory.

The result is stored using:

    register: ram_usage

The output is later accessed using:

    ram_usage.stdout

---

# 9. Storage Utilization

The playbook uses:

    df -h / | awk 'NR==2 {print $5}'

This checks the utilization of the root filesystem.

The result is stored using:

    register: storage_usage

The output is later accessed using:

    storage_usage.stdout

---

# 10. Hostname

Ansible gathers facts from the managed server using:

    gather_facts: true

The hostname is obtained from the gathered Ansible facts.

The playbook displays:

    ansible_hostname

---

# 11. Display the Report

The playbook uses the Ansible debug module:

    debug:
      msg:

The report displays:

    Hostname
    CPU Utilization
    RAM Utilization
    Storage Utilization

---

# 12. YAML Syntax Check

Before executing the playbook, the syntax was checked using:

    ansible-playbook assignment-02-server-utilization/server_report.yml --syntax-check -i inventory/hosts

Result:

    playbook: assignment-02-server-utilization/server_report.yml

No syntax error was reported.

---

# 13. Execute the Playbook

The playbook was executed using:

    ansible-playbook -i inventory/hosts assignment-02-server-utilization/server_report.yml

All tasks completed successfully.

---

# 14. Actual Server Utilization Report

The actual execution produced the following values:

    Hostname: ip-172-31-16-43
    CPU Utilization: 9%
    RAM Utilization: 37.89%
    Storage Utilization: 35%

These values were captured from the actual execution.

---

# 15. Play Recap

The final Ansible play recap was:

    web-01 : ok=5 changed=0 unreachable=0 failed=0 skipped=0 rescued=0 ignored=0

This confirms that:

- 5 tasks completed successfully
- No tasks failed
- The server was reachable
- No tasks were skipped

---

# 16. Save Output

The complete playbook execution output was saved using:

    ansible-playbook -i inventory/hosts assignment-02-server-utilization/server_report.yml | tee assignment-02-server-utilization/outputs/server-report.txt

The output file is:

    assignment-02-server-utilization/outputs/server-report.txt

The file contains the actual Ansible execution and final server utilization report.

---

# 17. Final Directory Structure

The final Assignment 2 structure is:

    assignment-02-server-utilization/
    │
    ├── server_report.yml
    │
    ├── STEPS.md
    │
    └── outputs/
        └── server-report.txt

---

# 18. Final Result

Assignment 2 was successfully completed.

The Ansible playbook successfully collected and displayed:

    Hostname: ip-172-31-16-43
    CPU Utilization: 9%
    RAM Utilization: 37.89%
    Storage Utilization: 35%

The execution completed with:

    failed=0
    unreachable=0

Therefore, the server utilization report was successfully generated using Ansible.
