System Health Report Automation assignment, create a README.md inside:

~/ansible-assignment/system-health-report

Run:

cd ~/ansible-assignment/system-health-report
vi README.md

Press i and paste the following complete README:

# Ansible System Health Report Automation

## 1. Assignment Objective

The objective of this assignment is to use Ansible to automatically collect system health information from multiple Linux servers and generate a consolidated health report.

The report is scheduled to run automatically every day at 9:00 AM IST using Linux Cron.

---

## 2. Architecture

```text
                    Ansible Controller
                    3.231.206.136
                          |
                          |
                    Ansible + Cron
                          |
              +-----------+-----------+
              |                       |
              |                       |
           web-01                  app-01
      100.55.58.125            100.48.196.30
              |                       |
              +-----------+-----------+
                          |
                   Health Checks
                          |
                   Consolidated Report
                          |
                          v
                  output/system-health-YYYY-MM-DD.txt
3. Infrastructure
Server	Role	Public IP
ansible_controller	Ansible Controller	3.231.206.136
web-01	Worker / Web Server	100.55.58.125
app-01	Worker / Application Server	100.48.196.30
4. Technologies Used
Linux / Ubuntu
Ansible
Ansible Playbook
SSH
AWS EC2
Bash
Cron
YAML
Vim
Git
5. Directory Structure
system-health-report/
│
├── inventory
├── system_health.yml
├── run_health_check.sh
├── README.md
│
└── output/
    ├── system-health-YYYY-MM-DD.txt
    └── cron.log
6. Ansible Controller Setup

The Ansible controller is the EC2 instance from which Ansible commands and playbooks are executed.

Controller:

3.231.206.136

Check the current user:

whoami

Expected:

ubuntu

Check Ansible installation:

ansible --version
7. SSH Authentication

The EC2 instances are accessed using an SSH private key.

The PEM file is stored on the controller at:

/home/ubuntu/aksh-keypair.pem

Set the correct permission:

chmod 400 /home/ubuntu/aksh-keypair.pem

Test SSH connectivity:

ssh -i /home/ubuntu/aksh-keypair.pem ubuntu@100.55.58.125
ssh -i /home/ubuntu/aksh-keypair.pem ubuntu@100.48.196.30
8. Inventory Configuration

The inventory file contains the worker servers.

Example:

[webserver]
web-01 ansible_host=100.55.58.125

[appserver]
app-01 ansible_host=100.48.196.30

[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=/home/ubuntu/aksh-keypair.pem

Test the inventory:

ansible-inventory -i inventory --graph
9. Test Ansible Connectivity

Run:

ansible all -i inventory -m ping

Expected result:

web-01 | SUCCESS
app-01 | SUCCESS

This confirms that the Ansible controller can communicate with both worker servers.

10. System Health Checks

The Ansible playbook collects the following information from each worker server:

CPU

Checks the number of CPUs available on the server.

Example command:

nproc
Memory

Checks total and available memory.

Example:

free -h
Operating System

Collects OS information such as:

Distribution
OS version
Kernel version
Uptime

Checks how long the server has been running.

Example:

uptime
Load Average

Checks the system load average.

Example:

cat /proc/loadavg
Disk Usage

Checks filesystem disk usage.

Example:

df -h
Disk Free Space

Checks available/free disk space.

This helps identify servers that are running low on storage.

SSH

Checks whether SSH is available on the server.

The SSH service is important because Ansible uses SSH to connect to the worker servers.

Failed Services

Checks whether any system services are currently in a failed state.

Example:

systemctl --failed
Overall Health Status

The collected information is consolidated into a health report.

The report can be used to identify potential system problems such as:

High CPU usage
Low memory
High disk utilization
Low disk space
Failed services
SSH problems
High system load
11. Playbook Execution

The main Ansible playbook is:

system_health.yml

Syntax check:

ansible-playbook -i inventory system_health.yml --syntax-check

Run the playbook manually:

ansible-playbook -i inventory system_health.yml
12. Manual Report Generation

The script:

run_health_check.sh

is used to execute the Ansible playbook.

Run:

./run_health_check.sh

The script executes the health-check playbook and generates the report.

13. Report Location

Reports are stored inside:

output/

Example:

output/system-health-2026-08-12.txt

View the report:

cat output/system-health-2026-08-12.txt

For a large report:

less output/system-health-2026-08-12.txt
14. Automated Daily Report Generation

Linux Cron is used to automate report generation.

Open the user's crontab:

crontab -e

The controller uses UTC timezone.

India Standard Time is UTC +5:30.

Therefore:

09:00 AM IST = 03:30 AM UTC

The permanent cron entry is:

30 03 * * * /home/ubuntu/ansible-assignment/system-health-report/run_health_check.sh >> /home/ubuntu/ansible-assignment/system-health-report/output/cron.log 2>&1
15. Cron Schedule Explanation

The cron format is:

MINUTE HOUR DAY MONTH WEEKDAY COMMAND

Our configuration:

30 03 * * *

means:

Minute = 30
Hour   = 03 UTC
Day    = Every day
Month  = Every month
Weekday = Every day

Therefore the report is generated every day at:

03:30 UTC
09:00 AM IST
16. Check Cron Configuration

Display the configured cron jobs:

crontab -l

Expected:

30 03 * * * /home/ubuntu/ansible-assignment/system-health-report/run_health_check.sh >> /home/ubuntu/ansible-assignment/system-health-report/output/cron.log 2>&1
17. Check Cron Service

Verify that the cron service is running:

systemctl status cron

If required:

sudo systemctl enable --now cron
18. Immediate Testing

To test the automation without waiting until 9:00 AM IST, temporarily add a cron entry for a few minutes ahead of the current UTC time.

Example:

52 17 * * * /home/ubuntu/ansible-assignment/system-health-report/run_health_check.sh >> /home/ubuntu/ansible-assignment/system-health-report/output/cron.log 2>&1

After the scheduled time, check:

ls -lh output/

The report should be generated automatically.

After testing, remove the temporary cron entry and keep the permanent 9:00 AM IST schedule.

19. Cron Log

Cron output is redirected to:

output/cron.log

Check the log:

cat output/cron.log

This can be used for troubleshooting scheduled execution.

20. Generated Reports

A new report is generated every day.

Example:

output/
├── system-health-2026-08-12.txt
├── system-health-2026-08-13.txt
├── system-health-2026-08-14.txt
└── cron.log

The date in the filename allows historical reports to be maintained instead of overwriting the previous day's report.

21. Troubleshooting
Inventory not found

If Ansible reports:

No inventory was parsed

Check:

cat inventory

Run:

ansible-inventory -i inventory --graph
SSH Permission Denied

Check the PEM file:

ls -l /home/ubuntu/aksh-keypair.pem

Set permission:

chmod 400 /home/ubuntu/aksh-keypair.pem

Test SSH manually:

ssh -i /home/ubuntu/aksh-keypair.pem ubuntu@<SERVER_IP>
Ansible Ping Test

Run:

ansible all -i inventory -m ping

Both servers should return:

SUCCESS
Cron Not Running

Check:

systemctl status cron

Check the configured schedule:

crontab -l

Check the cron log:

cat output/cron.log
22. Complete Execution Flow
1. Cron starts at 03:30 UTC
             |
             v
2. run_health_check.sh executes
             |
             v
3. Ansible Playbook starts
             |
             v
4. Ansible connects to web-01
             |
             v
5. Ansible connects to app-01
             |
             v
6. Health information is collected
             |
             v
7. Results are consolidated
             |
             v
8. Daily report is created
             |
             v
9. Report stored in output/
23. Validation

The assignment was tested successfully.

Example Ansible result:

app-01 : ok=21 changed=1 unreachable=0 failed=0
web-01 : ok=22 changed=2 unreachable=0 failed=0

Generated report:

output/system-health-2026-08-12.txt
24. Expected Result

The final solution provides:

Centralized health monitoring
Automated Ansible execution
CPU monitoring
Memory monitoring
OS information
Uptime
Load average
Disk usage
Disk free space
SSH availability
Failed service detection
Overall system health information
Daily report generation
Historical reports
Cron-based automation
25. Conclusion

This assignment demonstrates how Ansible can be used to automate Linux server health monitoring.

The Ansible controller connects to multiple worker servers using SSH, collects system health information, generates a consolidated report, and uses Linux Cron to automatically generate a new report every day at 9:00 AM IST.

The solution can be extended in the future with email notifications, Slack notifications, alert thresholds, centralized monitoring, and dashboard integration.


### Save the file in Vim

After pasting:

```text
Esc
:wq
Enter

Then verify:

cat README.md

And check your final structure:

tree

If tree isn't installed:

find . -maxdepth 2 -type f

Your final assignment should look roughly like:

system-health-report/
├── inventory
├── system_health.yml
├── run_health_check.sh
├── README.md
└── output/
    ├── system-health-2026-08-12.txt
    └── cron.log
