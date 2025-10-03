# Day 4 – EC2 Apache Web Server (Basic)

This lab creates:
- EC2 t3.micro instance using Amazon Linux 2023
- Installs Apache using `user_data`
- Security Group with SSH (22) and HTTP (80)

## How to run

```bash
terraform init
terraform apply -auto-approve
```

### Test the instance:
- SSH: use the `ssh_command` output
- HTTP: open the `http_url` in browser

## Cleanup

```bash
terraform destroy -auto-approve
```
