# Assignment 01 - Nginx Installation and Application Deployment

## Objective

Install Nginx on the web server using Ansible, change the default
Nginx port from 80 to 8081, deploy an HTML application, restart
Nginx and verify the application.

## Environment

| Component | Details |
|---|---|
| Ansible Controller | 172.31.18.103 |
| Web Server | web-01 |
| Web Server Private IP | 172.31.16.43 |
| Web Server Public IP | 13.220.177.221 |
| Operating System | Ubuntu |
| Web Server | Nginx |
| Nginx Port | 8081 |

## Directory Structure

```text
assignment-01-nginx/
├── nginx.yml
├── index.html
├── README.md
└── outputs/
    ├── ping.txt
    ├── playbook-output.txt
    ├── nginx-status.txt
    ├── nginx-port.txt
    ├── nginx-config-test.txt
    ├── application-local-test.txt
    └── application-public-test.txt
