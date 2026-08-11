# Assignment 2 - Tomcat

## Objective

Install Java and Tomcat on the application servers and change the Tomcat port from `8080` to `9090`.

## Target

The playbook targets:

```text
[appserver]
app-01
app-02
```

## Modules Used

| Module | Purpose |
|---|---|
| `apt` | Install Java and Tomcat |
| `replace` | Change Tomcat port |
| `service` | Restart, enable and verify Tomcat |

## Execution

```bash
ansible appserver -m ping
ansible-playbook assignment-02-tomcat/tomcat.yml
```

## What the playbook does

1. Connects to the appserver group.
2. Uses administrative privileges.
3. Installs Java.
4. Installs Tomcat.
5. Changes `8080` to `9090` in `server.xml`.
6. Restarts and enables Tomcat.
7. Verifies that Tomcat is started.

## Verification

```bash
ansible appserver -m shell -a "ss -tlnp | grep 9090"
```

You can also test:

```bash
curl http://localhost:9090
```

## Important

The example uses Tomcat 10 and `/etc/tomcat10/server.xml`. If your Ubuntu repository/class environment uses Tomcat 9, change the package and configuration path to `tomcat9` and `/etc/tomcat9/server.xml`.

## Trainer Explanation

> This playbook targets the application server group. I install Java because Tomcat requires Java. Then I install Tomcat, modify its server.xml configuration to change the port from 8080 to 9090, and restart the service so the new configuration takes effect.
