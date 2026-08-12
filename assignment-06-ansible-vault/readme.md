Objective

The objective of this assignment is to use Ansible Vault to securely store sensitive information such as passwords and use the encrypted variables in an Ansible playbook.

Directory Structure
assignment-06-ansible-vault/
│
├── README.md
├── vault.yml
├── secrets.yml
├── .gitignore
└── output/
    └── vault-output.txt
Step 1 – Navigate to Assignment Directory
cd ~/ansible-assignment/assignment-06-ansible-vault
Step 2 – Create secrets.yml

Create the secrets file:

nano secrets.yml

Add:

db_password: "MySecretPassword123"

Save and exit.

Step 3 – Encrypt secrets.yml

Encrypt the file using Ansible Vault:

ansible-vault encrypt secrets.yml

Enter and confirm a Vault password.

Expected:

Encryption successful

Verify:

cat secrets.yml

The file should now contain encrypted data beginning with:

$ANSIBLE_VAULT;1.1;AES256

The actual password should no longer be visible.

Step 4 – Create the Playbook

Create:

nano vault.yml

Use:

---
- name: Ansible Vault Demo
  hosts: appserver
  become: true

  tasks:

    - name: Load encrypted secrets
      include_vars:
        file: secrets.yml

    - name: Display secret
      debug:
        msg: "Database password is {{ db_password }}"

Save and exit.

Step 5 – Syntax Check

Run:

ansible-playbook -i ../inventory/hosts vault.yml --syntax-check --ask-vault-pass

Enter the Vault password.

Expected:

playbook: vault.yml
Step 6 – Execute the Playbook

Run:

ansible-playbook -i ../inventory/hosts vault.yml --ask-vault-pass

Enter the Vault password.

The playbook should execute successfully on:

app-01
app-02

Expected result:

PLAY RECAP
app-01    : ok=2    changed=0    failed=0
app-02    : ok=2    changed=0    failed=0
Step 7 – View the Encrypted File

To view the decrypted contents without permanently decrypting the file:

ansible-vault view secrets.yml

Enter the Vault password.

You should see:

db_password: "MySecretPassword123"
Step 8 – Verify the File Is Still Encrypted

Exit from the Vault view and run:

cat secrets.yml

It should still display:

$ANSIBLE_VAULT;1.1;AES256

This confirms that the secret remains encrypted.

Step 9 – Protect the Vault Password

If using a password file:

echo "YourVaultPassword" > .vault_pass

Set permissions:

chmod 600 .vault_pass

Then you can run:

ansible-playbook -i ../inventory/hosts vault.yml \
--vault-password-file .vault_pass
Step 10 – Add Sensitive Files to .gitignore

Create or edit:

nano .gitignore

Add:

.vault_pass
*.pem
*.key

Do not push .vault_pass to GitHub.

The encrypted secrets.yml can be included in the assignment repository, but the Vault password must remain private.

Step 11 – Save Output

To save the playbook execution output:

ansible-playbook -i ../inventory/hosts vault.yml \
--ask-vault-pass | tee output/vault-output.txt

Then verify:

cat output/vault-output.txt
Final Verification

Check the assignment:

cd ~/ansible-assignment/assignment-06-ansible-vault

ls -lah

Expected:

README.md
vault.yml
secrets.yml
.gitignore
output/

Check that secrets.yml is encrypted:

head -n 1 secrets.yml

Expected:

$ANSIBLE_VAULT;1.1;AES256
Commands Summary
Purpose	Command
Create secret	nano secrets.yml
Encrypt secret	ansible-vault encrypt secrets.yml
View secret	ansible-vault view secrets.yml
Syntax check	ansible-playbook -i ../inventory/hosts vault.yml --syntax-check --ask-vault-pass
Run playbook	ansible-playbook -i ../inventory/hosts vault.yml --ask-vault-pass
Create password file	echo "YourVaultPassword" > .vault_pass
Secure password file	chmod 600 .vault_pass
Run with password file	ansible-playbook -i ../inventory/hosts vault.yml --vault-password-file .vault_pass
Check encryption	head -n 1 secrets.yml
