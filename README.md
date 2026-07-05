# :rocket: Static Site Server — Nginx + Rsync Deployment

**Project Reference:** https://roadmap.sh/projects/static-site-server

---

## :book: Overview

This project demonstrates how to provision a Linux web server on AWS, configure **Nginx** to host a static website, and automate deployments using **rsync**.

The objective was to understand the fundamentals of web hosting, Linux server administration, and deployment automation.

---

## :dart: Project Goal

Set up a remote Linux server, install and configure **Nginx** to serve a static portfolio website, and use **rsync** to deploy updates quickly and efficiently from a local machine.

---

## :toolbox: Environment Details

| Component | Details |
|-----------|----------|
| Cloud Provider | AWS EC2 |
| Operating System | Amazon Linux 2023 |
| Instance Type | t3.micro (Free Tier Eligible) |
| Web Server | Nginx 1.30.2 |
| Deployment Tool | rsync |
| Automation | deploy.sh |
| Authentication | SSH Key Authentication |
| Local Machine | macOS |

---

# Project Preview

<div align="center">
    <img src="cloud-portfolio/screenshots/portfolio-homepage.png" width="900" alt="Cloud Portfolio Website">

</div>

---

## :globe_with_meridians: Live Demo

**Public IP**

```
http://18.170.68.229
```


**Note:** This EC2 instance is running temporarily for project submission and demonstration purposes.

---

# :white_check_mark: Project Requirements Completed


• :white_check_mark: Provisioned an AWS EC2 Linux server.
• :white_check_mark: Configured SSH key authentication.
• :white_check_mark: Installed and configured Nginx.
• :white_check_mark: Created a responsive static portfolio website.
• :white_check_mark: Hosted the website from the server.
• :white_check_mark: Configured rsync for deployments.
• :white_check_mark: Automated deployment using a Bash script.
• :white_check_mark: Served the website via the server's public IP address.

---

# :hammer_and_wrench: Step-by-Step Implementation

## 1. Launch AWS EC2 Instance

Created an Amazon Linux 2023 EC2 instance.

Configured the Security Group to allow:


• SSH (Port 22).
• HTTP (Port 80).

Connected securely using SSH key authentication.

### Command

```bash
ssh -i ~/.ssh/MyKeyPair.pem ec2-user@18.170.68.229
```

---

## 2. Update the Server

Updated all installed packages before installing additional software.

```bash
sudo dnf update -y
```

### Why?

Updating the system ensures the latest security patches and package versions are installed before configuring the server.

---

## 3. Install Nginx

Installed Nginx using the default Amazon Linux package repository.

```bash
sudo dnf install -y nginx
```

Enabled and started the service.

```bash
sudo systemctl enable --now nginx
```

Verified that Nginx was running.

```bash
sudo systemctl status nginx
```

---

## 4. Create the Website Directory

Created a dedicated directory to host the website files.

```bash
sudo mkdir -p /var/www/portfolio
```

Changed ownership so files could be deployed without permission issues.

```bash
sudo chown -R ec2-user:ec2-user /var/www/portfolio
```

---

## 5. Configure Nginx

Created a new server block.

Location:

```
/etc/nginx/conf.d/portfolio.conf
```

Configuration:

```nginx
server {
    listen 80;
    server_name _;

    root /var/www/portfolio;

    index index.html;
}
```

Tested the configuration.

```bash
sudo nginx -t
```

Restarted Nginx.

```bash
sudo systemctl restart nginx
```

### Why?

Instead of using the default Nginx webpage, this configuration tells Nginx to serve files from the custom portfolio directory.

---

## 6. Create the Static Website

Created a simple responsive portfolio website containing:


• index.html.
• style.css.
• profile.jpg.

The page includes:


• Personal introduction.
• Technical skills.
• GitHub projects.
• LinkedIn profile.
• Contact information.

---

## 7. Deploy Using Rsync

Created a deployment script named:

```
deploy.sh
```

```bash
#!/bin/bash

SERVER="ec2-user@18.170.68.229"
REMOTE_PATH="/var/www/portfolio"
KEY_PATH="$HOME/.ssh/MyKeyPair.pem"

rsync -avz --delete \
-e "ssh -i $KEY_PATH -o IdentitiesOnly=yes -o WarnWeakCrypto=no" \
./ $SERVER:$REMOTE_PATH/
```

Made the script executable.

```bash
chmod +x deploy.sh
```

Executed deployment.

```bash
./deploy.sh
```

### Why rsync?

Unlike copying every file manually, **rsync** only transfers the files that have changed, making deployments much faster and more efficient.

---

## 8. Configure Permissions

Ensured Nginx could access all website files.

```bash
sudo chown -R nginx:nginx /var/www/portfolio
```

Configured the correct SELinux context.

```bash
sudo chcon -R -t httpd_sys_content_t /var/www/portfolio
```

---

## :open_file_folder: Project Structure

```
static-site-server/
│
├── index.html
├── style.css
├── profile.jpg
├── deploy.sh
├── README.md
└── screenshots/
    └── portfolio-homepage.png
```

---

# :books: Skills Demonstrated


• AWS EC2.
• Linux Administration.
• Nginx Configuration.
• HTML & CSS.
• SSH Authentication.
• rsync.
• Bash Scripting.
• Static Website Hosting.
• Deployment Automation.

---

# :book: What I Learned

Through this project I learned how to:


• Provision a Linux server in AWS.
• Configure Nginx as a web server.
• Host a static website.
• Deploy changes efficiently using rsync.
• Automate deployments with Bash.
• Configure Linux file ownership and permissions.
• Troubleshoot common Nginx configuration issues.

---

# :clipboard: Submission Checklist


• :white_check_mark: Public GitHub repository.
• :white_check_mark: README.md included.
• :white_check_mark: Project reference included.
• :white_check_mark: Live site accessible.
• :white_check_mark: Deployment automation completed.
• :white_check_mark: Screenshot included.

---

# :checkered_flag: Project Status

**Completed** :white_check_mark:
