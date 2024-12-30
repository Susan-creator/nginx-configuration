# NGINX Deployment with Terraform and Ansible

This project demonstrates the automation of deploying NGINX on worker nodes using Terraform to provision infrastructure on AWS and Ansible for configuration management.

## Project Overview

- **Terraform** is used to create and manage AWS resources, including EC2 instances for the master and target nodes.
- **Ansible** is used to configure the EC2 instances and install NGINX only on the target nodes.

### Components:
1. **Terraform**:
   - Creates EC2 instances for master and target nodes.
   - Configures security groups, key pairs, and other AWS infrastructure needed for the deployment.

2. **Ansible**:
   - Installs NGINX on the target nodes.
   - Ensures that the master node does not have NGINX installed (it is the control node).

---

## Prerequisites

To run this project, make sure you have the following tools installed:

- [Terraform](https://www.terraform.io/downloads.html)
- [Ansible](https://www.ansible.com/)
- [AWS CLI](https://aws.amazon.com/cli/)
- [Git](https://git-scm.com/)

You also need:
- AWS Account with access to create EC2 instances.
- SSH key pair for accessing EC2 instances.

---

## Setup Instructions

### 1. Clone the Repository


git clone https://github.com/Susan-creator/nginx-configuration.git
cd nginx-configuration

Set up Terraform
Update the terraform/main.tf file with your own AWS access keys and other relevant configuration.

Initialize Terraform in the project directory:
terraform init

Apply the Terraform configuration to provision the EC2 instances:
terraform apply

This will create EC2 instances for the master and target nodes, as defined in your main.tf file.

Set up Ansible
Update the inventory.ini file with the public IPs of your master and worker EC2 instances.
ini

[master]
<master-ip>

[targets]
<worker-ip-1>
<worker-ip-2>
Ensure the site.yml Ansible playbook is configured as follows:
---
- name: Configure nginx on master node (no nginx install here)
  hosts: master
  become: true
  tasks:
    # Any tasks for the master node can be placed here
    # For example, tasks related to configuration, etc.
    - name: Example task for master node
      debug:
        msg: "Master node configuration done, no NGINX installed."

- name: Install NGINX on target nodes
  hosts: target  # Only the worker nodes
  become: true
  tasks:
    - name: Install NGINX
      ansible.builtin.package:
        name: nginx
        state: present
    - name: Start nginx
      service:
        name: nginx
        state: started

Run Ansible Playbook
Run the Ansible playbook to configure NGINX on the target nodes:
ansible-playbook -i inventory.ini site.yml

This will install and start NGINX on the worker nodes, while leaving the master node untouched.

Directory Structure
nginx-configuration/
├── ansible/
│   ├── inventory.ini      # Inventory file for Ansible
│   └── site.yml           # Ansible playbook
├── terraform/
│   └── main.tf            # Terraform configuration for AWS resources
├── .gitignore             # Git ignore file
├── README.md              # Project README
└── output/                # Terraform output logs


Troubleshooting
If you encounter an issue where NGINX is installed on the master node, ensure the playbook is correctly targeting only the worker nodes, as described in the site.yml file.
Make sure that your AWS EC2 instances are accessible via SSH and that the necessary security group rules (e.g., allowing SSH access) are in place.


Future Enhancements
Automate scaling of target nodes using Terraform.
Set up a load balancer in front of the target nodes.
Add more Ansible tasks for advanced NGINX configurations (e.g., reverse proxy setup).



