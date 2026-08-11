# Assignment 7 - Steps

## 1. Navigate to the assignment
```bash
cd ~/ansible-assignment/assignment-07-dynamic-inventory
```

## 2. Verify AWS CLI
```bash
aws --version
aws sts get-caller-identity
```

## 3. Verify EC2 access
```bash
aws ec2 describe-instances --region us-east-1
```

## 4. Install the AWS collection if required
```bash
ansible-galaxy collection install amazon.aws
```

## 5. Verify the dynamic inventory
```bash
ansible-inventory -i aws_ec2.yml --graph
```

## 6. List discovered hosts
```bash
ansible-inventory -i aws_ec2.yml --list
```

## 7. Test all discovered hosts
```bash
ansible all -i aws_ec2.yml -m ping
```

## 8. Test application servers
```bash
ansible appserver -i aws_ec2.yml -m ping
```

## 9. Test web server
```bash
ansible webserver -i aws_ec2.yml -m ping
```

## 10. Test database server
```bash
ansible dbserver -i aws_ec2.yml -m ping
```

## 11. Save inventory output
```bash
ansible-inventory -i aws_ec2.yml --graph | tee outputs/inventory-graph.txt
```

## 12. Save ping output
```bash
ansible all -i aws_ec2.yml -m ping | tee outputs/ping-output.txt
```

## Expected AWS tags
- web server: `abc=webserver`
- application servers: `env=appserver`
- database server: `xyz=dbserver`

## Note
The previous EC2 instances were terminated. Recreate the required infrastructure, apply the appropriate AWS tags, and then run these commands.
