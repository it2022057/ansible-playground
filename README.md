# 🚀 Ansible Playground 

This repository contains an Ansible-based automation environment for deploying a complete multi-component application stack on remote Microsoft Azure VMs. Also, it can install all the components in a docker environment using ansible with docker-compose. Specifically, the components are the following:

* Spring Boot Application (main app)
* Database (MariaDB)
* Mailhog (Mail testing SMTP server)
* MinIO (object storage)

## 📁 Project set up
* create an inventory file (e.g. hosts or hosts.yaml) that holds the remote hosts that ansible will handle.
* Example entry is
```yaml
webserver: # <-- group
  hosts: # <-- List of hosts in group
    gcloud_host: # <-- host number 1 in group
      ansible_host: "your_public_ip"
      ansible_port: "your_port"
      ansible_ssh_user: "your_user"
    app01:  # <-- host number 2 in group
      ansible_host: server01
    app02:  # <-- host number 3 in group
      ansible_host: server02
  vars:  # <-- common variables in this group
    ansible_python_interpreter: /usr/bin/python3
```

## 🔍 Troubleshooting

* to test if all hosts are accesible, run
```bash
ansible -m ping all
```
* to test if a group of hosts are accesible, run
```bash
ansible -m ping all <group-name>
```

## 📤 Install Ansible

```bash
sudo apt update
sudo apt install ansible
```

## 🗃️ Clone project

With https (keep in mind it will ask for credentials because it is a private repository)
```bash
git clone https://github.com/it2022057/ansible-playground.git
```
or with ssh key (if you have one)
```bash
git clone git@github.com:it2022057/ansible-playground.git
```

## ☁️ Ansible environment deploy

* All the components of the system
```bash
ansible-playbook playbook/setup_all.yaml -l devops-vm-2,db-server
```

* Only the mariaDB deployment
```bash
ansible-playbook playbook/mariaDB.yaml
```

* Only the main app deployment (i put a limit to deploy only in one azure vm that is for ansible deployment)
```bash
ansible-playbook playbook/spring.yaml -l devops-vm-2
```

* Only the mailhog deployment (i put a limit to deploy only in one azure vm that is for ansible deployment)
```bash
ansible-playbook playbook/mailhog.yaml -l devops-vm-2
```

* Only the minio deployment (i put a limit to deploy only in one azure vm that is for ansible deployment)
```bash
ansible-playbook playbook/minIO.yaml -l devops-vm-2
```

## ☁️ Docker environment deployed with ansible

* Docker compose runs in the devops-vm-3
```bash
ansible-playbook playbook/docker_run.yaml
``` 


# 🧾 Results
---

#### If everything ran successfully, go to the following urls and then check for the results!!! Keep in mind we use nginx to handle incoming HTTP requests and forward them to the appropriate Docker containers (e.g., Spring Boot, MinIO, Mailhog). It acts as a reverse proxy, enabling clean and consistent URLs and port consolidation (all services behind port 80/443). So we can either access the components via their public ip's and ports(discouraged) or by the following url's:


## 🛡️ Main app page

* devops-vm-1
```bash
https://vm1.loukidns.ip-ddns.com
```
* devops-vm-2
```bash
https://vm2.loukidns.ip-ddns.com
```
* devops-vm-3
```bash
https://vm3.loukidns.ip-ddns.com
```

## 📬 Mailhog UI 

* devops-vm-1
```bash
https://vm1.loukidns.ip-ddns.com/mailhog/
```
* devops-vm-2
```bash
https://vm2.loukidns.ip-ddns.com/mailhog/
```
* devops-vm-3
```bash
https://vm3.loukidns.ip-ddns.com/mailhog/
```

## 🪣 Minio console

* devops-vm-1
```bash
https://vm1.loukidns.ip-ddns.com/minio/
```
* devops-vm-2
```bash
https://vm2.loukidns.ip-ddns.com/minio/
```
* devops-vm-3
```bash
https://vm3.loukidns.ip-ddns.com/minio/
```

## 🏷️ Public Ip's

* db-server
```bash
4.223.107.0
```

* devops-vm-1 with all the rest of the components (except db)
```bash
135.225.114.238
```

* devops-vm-2 with all the rest of the components (except db)
```bash
20.234.5.108
```

* devops-vm-3 for the docker-compose deployment
```bash
20.91.248.188
```

## 📦 Vagrant guide for deploying local vms
* Vagrant install https://developer.hashicorp.com/vagrant/downloads 

### 🔌 Plugins in order to run more efficiently your local vms

```bash
vagrant plugin install vagrant-hostmanager
vagrant plugin list
vagrant plugin update
```

* For arch based linux distro 
```bash
VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT=1 vagrant plugin install hostmanager
```

* If you want to make a Vagrantfile with an ububtu 22.04 box, run

```bash
vagrant init ubuntu/jammy64
```

* To deploy the vms run
```bash
vagrant up
```
or
```bash
vagrant up <name> 
```

* To see the vms (we must be in the directory where the Vagrantfile is)
```bash
vagrant status
```

* To ssh in a vagrant vm
```bash
vagrant ssh <vm-name>
```

* In order to stop the vagrant vms, run
```bash
vagrant halt
```

## 🔷 Azure VMs

* If you want to deploy web servers in microsoft azure, you can visit this website and check the available free credits here: https://azure.microsoft.com/en-us/free/students

## 🔗 Links
* [mailhog (email testing)](https://github.com/mailhog/MailHog)
* [minio (object storage)](https://min.io/)
* [apt module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/apt_module.html)
* [file module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/file_module.html)
* [copy module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/copy_module.html)
* [service module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/service_module.html)
* [debconf module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/debconf_module.html)
* [import_playbook module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/import_playbook_module.html)
* [get_url module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/get_url_module.html)
* [mail module](https://docs.ansible.com/ansible/2.9/modules/mail_module.html)
* [mysql_db module](https://docs.ansible.com/ansible/latest/collections/community/mysql/mysql_db_module.html)
* [mysql_role module](https://docs.ansible.com/ansible/latest/collections/community/mysql/mysql_role_module.html)
* [docker_compose module](https://docs.ansible.com/ansible/latest/collections/community/docker/docker_compose_v2_module.html)
* [git module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/git_module.html)
* [script module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/script_module.html)
* [set_fact module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/set_fact_module.html)

## ✍️ Author

Made with ❤️ by **it2022057**