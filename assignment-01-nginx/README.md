# Assignment 1 - Nginx

## Objective

Install Nginx on the web servers, change the Nginx listening port from `80` to `8081`, and deploy a simple HTML application.

## Target

The playbook targets:

```text
[webserver]
web-01
web-02
```

## Modules Used

| Module | Purpose |
|---|---|
| `apt` | Install Nginx |
| `copy` | Deploy the HTML application |
| `replace` | Change the Nginx port |
| `command` | Run `nginx -t` to validate configuration |
| `service` | Restart and enable Nginx |

## Execution

From the repository root:

```bash
ansible all -m ping
ansible-playbook assignment-01-nginx/nginx.yml
```

## What the playbook does

1. Connects to the `webserver` group.
2. Uses `become: yes` for administrative privileges.
3. Installs Nginx.
4. Copies `files/index.html` to `/var/www/html/index.html`.
5. Changes Nginx from port `80` to `8081`.
6. Tests the Nginx configuration.
7. Restarts and enables Nginx.

## Verification

```bash
ansible webserver -m shell -a "ss -tlnp | grep 8081"
ansible webserver -m shell -a "curl -s http://localhost:8081"
```

You can also open:

```text
http://SERVER-IP:8081
```

For AWS, allow TCP port `8081` in the instance Security Group if you want to access it externally.

## Trainer Explanation

> This playbook targets my webserver group. It installs Nginx using the apt module, deploys an HTML application using the copy module, changes the listening port from 80 to 8081 using the replace module, validates the configuration with nginx -t, and restarts the Nginx service.
