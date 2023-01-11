`ansible: v2.14.1` `ansible-lint: v6.10.0` `python: v3.10.9`

## Before running the project.
1. [Install ansible.](https://www.gss.com.tw/blog/ansible-4-%E5%AE%89%E8%A3%9D%E7%AF%87-mac)
```bash
brew install ansible
pip3 install ansible-lint # Optional
brew install hudochenkov/sshpass/sshpass

# Check
ansible --version
ansible-lint --version # Optional
```

- Check syntax (Optional)
```bash
ansible-lint <your playbook>
```

2. [Install docker collection](https://galaxy.ansible.com/community/docker)
```bash
ansible-galaxy collection install community.docker

# Check
ansible-galaxy collection list
```

3. Customize your data.
- Modify `hosts` with your hostname and user.
- Modify `ansible.cfg` with your `private_key_file` path.
- Modify `./infra/config/config.s3.tfbackend` with your config values.
- Run the following command to check connection.
```bash
# `server` indicate `[server]` in `hosts`.
# You can use `all` instead of `server` to ping all the inventory in `hosts`.
ansible server -m ping
```

## Use Ansible server to run terraform on controller node (EC2).
1. Setup Security group and IAM to your EC2 instance.

2. Run playbook
```bash
ansible-playbook deploy_s3bucket.yml

# If your file is encrypted.
ansible-playbook deploy_s3bucket.yml -i hosts --ask-vault-pass
```

## Use Ansible server to setup Jenkins on controller node (EC2).
1. Setup Security group and IAM to your EC2 instance.

2. Run playbook
```bash
ansible-playbook deploy_docker_jenkins.yml

# If your file is encrypted.
ansible-playbook deploy_docker_jenkins.yml -i hosts --ask-vault-pass
```

3. Open your browser and enter your EC2's Public IPv4 DNS with port 8080 (http).

## Use local Jenkins server's pipeline to run Ansible which run terraform on controller node (EC2).

1. [Run jenkins with docker](https://hub.docker.com/_/jenkins#:~:text=out%20jenkinsci/jenkins-,How%20to%20use%20this%20image,-docker%20run%20%2Dp)
```bash
docker run --name myjenkins -p 8080:8080 -p 50000:50000 -v $HOME:/var/jenkins_home jenkins/jenkins:lts-jdk11
```

2. Access http://localhost:8080 and authorized with admin password. Default path of password is `/var/jenkins_home/secrets/initialAdminPassword`.

3. Install Ansible with available version
```bash
# Enter container with root user.
docker exec -it --user root myjenkins bash

# Install Ansible
apt update
apt install ansible

# Check version
ansible --version
```

4. [Follow the video to create git repo credential](https://www.youtube.com/watch?v=AG26QMUFzrw)

5. [Follow the tutorial to setup Ansible plugin, Jenkins Pipeline](https://www.youtube.com/watch?v=PRpEbFZi7nI)
- Run `which ansible` to show the path.
- Navigate to `Dashboard > Manage Jenkins > Global Tool Configuration` and setup Ansible.

6. After building the pipeline, Jenkins will load the Jenkinsfile and update the content.