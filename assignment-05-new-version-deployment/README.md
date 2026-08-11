# Assignment 5 - New Version Deployment

## Objective
Deploy a new version of the Book Seller application on the application servers using Ansible.

## Structure
- `deployment.yml` - Ansible deployment playbook
- `STEPS.md` - execution and verification steps
- `outputs/` - execution evidence/output files
- `book-seller-new.war` - application artifact, to be supplied separately when executing

## Target Servers
- app-01
- app-02

## Deployment Flow
1. Stop Tomcat.
2. Back up the existing WAR.
3. Remove the old exploded application.
4. Deploy the new WAR.
5. Start and enable Tomcat.
6. Wait for port 9090.
7. Perform an application health check.

## Important
The EC2 instances used during the practical execution were terminated. The playbook is retained as submission-ready code and can be executed after recreating the infrastructure and supplying the WAR file.
