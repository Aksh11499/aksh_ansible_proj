# Assignment 7 - Dynamic Inventory

## Objective
Use Ansible dynamic inventory to automatically discover AWS EC2 instances instead of maintaining static IP addresses.

## Target Environment
- 1 web server
- 2 application servers
- 1 database server
- 1 Ansible controller

## Expected Groups
AWS tags are used to create:
- `webserver`
- `appserver`
- `dbserver`

## Files
- `aws_ec2.yml` - AWS EC2 dynamic inventory configuration
- `STEPS.md` - setup, verification, and execution steps
- `outputs/` - command output/evidence

## AWS Checks
```bash
aws sts get-caller-identity
aws ec2 describe-instances --region us-east-1
```

## Important
The EC2 instances previously used for the assignments were terminated. This assignment contains the dynamic-inventory configuration and documentation for reuse after the required EC2 infrastructure is recreated.
