# Terraform-Remote_Provider
## This lab demonstrates how we can use remote provisioners to excute code on an EC2 instance after creating it
Run commands on an EC2 instance right after creation using Terraform.
In this exercise, we will use Terraform remote provisioners to connect to a newly created EC2 instance over SSH and execute commands automatically after the instance is launched.

The goal is simple:

- Deploy an EC2 instance

- SSH into it from Terraform

- Install and start a web server (Apache)

- Create a basic HTML page that shows the hostname

Everything is done from Terraform with no manual SSH steps.

<img width="1090" height="680" alt="image" src="https://github.com/user-attachments/assets/82f8ac97-0d6f-4fd9-ba31-12b29b7dec9a" />

## What will run on the EC2 instance

The commands are executed remotely on the first creation of the instance:

  
## This will:

- Update the OS packages (Amazon Linux 2023 uses dnf)

- Install Apache (httpd)

- Start and enable the service

- Create a simple web page

 ## Prerequisites

- Terraform installed

- AWS CLI configured (aws configure)

- An existing EC2 key pair in AWS (example name: New_Key_Pair)

- The matching private key file downloaded locally

A security group that allows:

- Inbound SSH (22) from your public IP

- Inbound HTTP (80) from anywhere (0.0.0.0/0)

## Deploying the infrastructure

Run the following commands from the folder containing your Terraform file:

- terraform init
- terraform validate
- terraform plan
- terraform apply -auto-approve


Terraform will:

- Create the EC2 instance

- Wait for it to become reachable over SSH

- Connect using your key pair

- Run the Apache installation commands remotely

## Access the web page

After the apply finishes, Terraform outputs the public DNS name.
<img width="647" height="52" alt="image" src="https://github.com/user-attachments/assets/33de0362-5f7b-4f30-b4fa-de6b7c83695e" />

## How it works

- connection block tells Terraform how to SSH into the instance.

- remote-exec runs commands over that SSH session.

- This is useful for quick configuration or demos.

For larger or production setups, consider:

- user_data (cloud-init) for bootstrapping

- Configuration management tools (Ansible, etc.)

## Clean up

To delete the instance and avoid charges:

- terraform destroy -auto-approve
