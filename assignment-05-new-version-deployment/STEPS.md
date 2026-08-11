# Assignment 5 - Steps

## 1. Navigate to the assignment
```bash
cd ~/ansible-assignment/assignment-05-new-version-deployment
```

## 2. Provide the application artifact
Place `book-seller-new.war` in the same directory as `deployment.yml`.

## 3. Verify inventory
Use the project inventory or update the target hosts with the current application-server IP addresses.

## 4. Syntax check
```bash
ansible-playbook -i ../inventory/hosts deployment.yml --syntax-check
```

## 5. Verify Tomcat
```bash
ansible appserver -i ../inventory/hosts -m shell -a "systemctl status tomcat --no-pager" --become
```

## 6. Verify port 9090
```bash
ansible appserver -i ../inventory/hosts -m shell -a "ss -lntp | grep 9090" --become
```

## 7. Deploy
```bash
ansible-playbook -i ../inventory/hosts deployment.yml
```

## 8. Save output
```bash
ansible-playbook -i ../inventory/hosts deployment.yml | tee outputs/deployment-output.txt
```

## 9. Verify deployment
```bash
ansible appserver -i ../inventory/hosts -m shell -a "ls -lh /opt/tomcat/webapps/" --become
```

## 10. Verify application
The playbook checks:
`http://127.0.0.1:9090/book-seller/`

Expected HTTP status: `200`

## Note
The previous EC2 instances were terminated, so historical IP addresses should not be treated as currently reachable.
