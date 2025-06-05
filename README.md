# WordPress on AWS EC2 - Automated Deployment

## 👨‍💻 Author Information
**Name:** Muhammad Ahsan  
**Student ID:** 34898994  
**GitHub Repository:** **wp-installation-automation**  
**Project Repository:** [muhammadahsan34898994/wp-installation-automation](https://github.com/muhammadahsan34898994/wp-installation-automation)

## 🚀 Live Demo
Experience the fully deployed WordPress website with SSL security and custom domain integration:  
**🌐 Live Website:** [https://muhammad34898994.zapto.org](https://muhammad34898994.zapto.org)

*This live demonstration showcases a complete WordPress deployment on AWS EC2 with automated SSL certificate installation and dynamic DNS configuration.*

## 📋 Project Overview

This project demonstrates the end-to-end deployment of a fully functional, secure, and publicly accessible WordPress website hosted on AWS EC2. It simulates a real-world cloud infrastructure setup for small businesses or personal portfolios using cost-effective and scalable technologies.

The implementation spans infrastructure provisioning, server configuration, content management setup, automation scripting, domain integration, and HTTPS security. Every step reflects modern DevOps principles and cloud best practices.

### 🎯 Key Deliverables

- ✅ Provisioned EC2 Instance (Ubuntu Server) with public access via Elastic IP
- ✅ Installed & Secured LAMP Stack (Linux, Apache, MySQL, PHP)
- ✅ Deployed WordPress CMS with functional theme and content
- ✅ Automated Setup Script hosted on GitHub for one-line deployment
- ✅ Custom Domain mapped using free dynamic DNS (No-IP)
- ✅ SSL Secured Website using Let's Encrypt and Certbot
- ✅ Live Online Website available at: https://muhammad34898994.zapto.org

### 📚 Educational & Technical Objectives

- Learn and apply cloud provisioning with AWS EC2
- Practice secure Linux server setup and updates
- Understand manual and scripted WordPress deployment
- Integrate DNS and dynamic IP resolution using a free provider
- Implement SSL/TLS certificates for HTTPS
- Gain foundational DevOps automation skills

## 💻 GitHub View

For this project, my personal GitHub account was used under the username **muhammadahsan34898994**. Within this account, a dedicated repository was created named **wp-installation-automation**. The goal of this repository is to host all related assets.

**GitHub Repository URL:** [https://github.com/muhammadahsan34898994/wp-installation-automation](https://github.com/muhammadahsan34898994/wp-installation-automation)

![GitHub Repository](docs/images/1.png)

### Repository Contents
- **Script File:** `install-wordpress.sh` - Automates downloading, configuring, and setting up WordPress
- **Open Access:** Public repo URL for review, reuse, and collaboration

![Repository Contents](docs/images/2.png)

### Commit History
The GitHub commit history documents the evolution of the script and provides full transparency into how the repository was developed. Each commit reflects a change or improvement made to the project, including bug fixes, enhancements, and refinements to automation. This history demonstrates active project development, attention to detail, and iterative improvement — all key practices in software development and DevOps workflows.

![Commit History](docs/images/3.png)

## 🛠️ Quick Start (One-Line Installation)

```bash
curl -s https://raw.githubusercontent.com/muhammadahsan34898994/wp-installation-automation/main/install-wordpress.sh | bash
```

**Prerequisites:**
- Fresh Ubuntu 22.04 EC2 instance
- LAMP stack installed and configured
- MySQL database and user created
- Apache web server running

## 📁 Repository Structure

```
wp-installation-automation/
├── README.md
├── install-wordpress.sh    # Main automation script
└── docs/                   # Documentation and images
```

## 🔧 Manual Installation Steps

### 1. Create Linux-based EC2 Instance

**Configuration:**
- **AMI:** Ubuntu Server 22.04 LTS (free tier eligible)
- **Instance Type:** t2.micro
- **Storage:** 20 GB EBS volume
- **Security Group:** Allow ports 80 (HTTP), 443 (HTTPS), and 22 (SSH)
- **Elastic IP:** Allocated and attached for static public IP

![EC2 Instance Configuration](docs/images/4.png)

### 2. Server Preparation

#### System Update
```bash
sudo apt update && sudo apt upgrade -y
```

#### Install Apache Web Server
```bash
sudo apt install apache2 -y
sudo systemctl status apache2
```

#### Install PHP and Required Extensions
```bash
sudo apt install php libapache2-mod-php php-mysql -y
php -v
```

#### Install MySQL Database Server
```bash
sudo apt install mysql-server -y
sudo systemctl status mysql
```

#### Secure MySQL Installation
```bash
sudo mysql_secure_installation
```

**Security Configuration:**
- ✅ Enable Validate Password Plugin: **YES**
- ✅ Password Validation Policy: **STRONG (2)**
- ✅ Remove Anonymous Users: **YES**
- ✅ Disallow Remote Root Login: **YES**
- ✅ Remove Test Database: **YES**
- ✅ Reload Privileges: **YES**

#### Create WordPress Database and User
```sql
sudo mysql

CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'StrongP@ssw0rd!';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### 3. WordPress Configuration

#### Download and Extract WordPress
```bash
cd /tmp
curl -O https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
```

#### Copy WordPress Files to Web Root
```bash
sudo cp -a wordpress/. /var/www/html/
```

#### Set Permissions
```bash
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/
```

#### Configure WordPress
```bash
cd /var/www/html/
sudo rm -f index.html
sudo mv wp-config-sample.php wp-config.php
sudo nano wp-config.php
```

**Database Configuration:**
```php
define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'wpuser' );
define( 'DB_PASSWORD', 'StrongP@ssw0rd!' );
define( 'DB_HOST', 'localhost' );
```

#### Restart Apache
```bash
sudo systemctl restart apache2
```

### 4. Domain Name and SSL Certificate

#### Configure Free Dynamic Domain (No-IP)
- **Domain:** muhammad34898994.zapto.org
- **Service:** No-IP dynamic DNS
- **Mapping:** Domain → EC2 Public IP

![No-IP Configuration](docs/images/5.png)

#### Install Certbot (Let's Encrypt)
```bash
sudo apt install certbot python3-certbot-apache -y
```

#### Generate and Install SSL Certificate
```bash
sudo certbot --apache -d muhammad34898994.zapto.org
```

**SSL Setup Process:**
1. **Email Address:** mydomaine.ges@gmail.com
2. **Terms of Service:** Accepted
3. **Email Sharing:** Consented
4. **Result:** HTTPS enabled successfully

![SSL Certificate Installation](docs/images/6.png)

## 📜 Automation Script Explanation

### Purpose and Motivation
The automation script streamlines WordPress deployment by consolidating all manual commands into a single executable file, enhancing:
- **Efficiency:** Automates what would normally take several minutes
- **Repeatability:** Ensures consistency across environments
- **Scalability:** Can be reused for future deployments

### Script Workflow

1. **Download WordPress**
   ```bash
   cd /tmp
   curl -O https://wordpress.org/latest.tar.gz
   ```

2. **Extract and Clean**
   ```bash
   tar -xzf latest.tar.gz
   sudo rm -rf /var/www/html/*
   ```

3. **Deploy Files**
   ```bash
   sudo cp -a wordpress/. /var/www/html/
   ```

4. **Set Permissions**
   ```bash
   sudo chown -R www-data:www-data /var/www/html/
   sudo chmod -R 755 /var/www/html/
   ```

5. **Configure WordPress**
   ```bash
   sudo mv wp-config-sample.php wp-config.php
   # Inject database credentials using sed
   ```

6. **Restart Services**
   ```bash
   sudo systemctl restart apache2
   ```

## 🧪 Test Results

### Execution Log
```bash
$ curl -s https://raw.githubusercontent.com/muhammadahsan34898994/wp-installation-automation/main/install-wordpress.sh | bash

Downloading WordPress...
Cleaning /var/www/html/...
Copying WordPress files to /var/www/html/...
Cleaning up temporary files...
Setting ownership and permissions...
Configuring WordPress...
Restarting Apache...
WordPress is installed, configured, and ready to go!
```

### Verification Steps
| Step | Result | Status |
|------|--------|--------|
| WordPress downloaded | Archive fetched from official source | ✅ |
| WordPress extracted | Files unpacked to /tmp/wordpress | ✅ |
| Cleaned existing /var/www/html | Old content removed | ✅ |
| Files copied | WordPress files moved to web root | ✅ |
| Permissions set | www-data assigned as owner | ✅ |
| Config updated | wp-config.php correctly edited | ✅ |
| Apache restarted | WordPress accessible via browser | ✅ |

## 💰 Total Cost of Ownership (TCO)

| Component | Service | Estimated Cost | Notes |
|-----------|---------|----------------|-------|
| EC2 Instance (t2.micro) | AWS | $0.00 (Free Tier) | 750 hours/month for 12 months |
| Elastic IP | AWS | $0.00 (if attached) | Free when assigned to running instance |
| Storage (EBS, 20GB) | AWS | $0.00 (Free Tier) | Up to 30GB under Free Tier |
| Domain Name | No-IP | $0.00 | Free dynamic DNS domain |
| SSL Certificate | Let's Encrypt | $0.00 | Free SSL via Certbot |
| WordPress | Open Source | $0.00 | Free CMS, self-hosted |
| Additional Software | Ubuntu APT | $0.00 | Apache, PHP, MySQL, Certbot |

**Total Monthly Cost: $0.00**

*Note: After the 12-month Free Tier period, costs may be $3-10/month depending on usage.*

## 🎯 Final Results

### Deployment Status
| Component | Description | Status |
|-----------|-------------|--------|
| EC2 + Elastic IP | Compute host with static IP | ✅ |
| LAMP Stack | Apache, PHP, and MySQL | ✅ |
| WordPress | Manual + automated installation | ✅ |
| MySQL DB | Dedicated database and secured user | ✅ |
| Theme | Twenty Twenty-Four | ✅ |
| Domain Name | No-IP dynamic DNS | ✅ |
| SSL | Let's Encrypt certificate | ✅ |

### Live Website
🌐 **[https://muhammad34898994.zapto.org](https://muhammad34898994.zapto.org)**

## 📚 References

- [AWS EC2 Documentation](https://docs.aws.amazon.com/kinesisvideostreams/latest/dg/gs-ubuntu.html)
- [WordPress on EC2 Tutorial](https://docs.aws.amazon.com/codedeploy/latest/userguide/tutorials-wordpress.html)
- [Ubuntu Server Documentation](https://documentation.ubuntu.com/server/)
- [Apache Documentation](https://httpd.apache.org/docs/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Connect & Support

**GitHub Profile:** [@muhammadahsan34898994](https://github.com/muhammadahsan34898994)  
**This Project:** [wp-installation-automation](https://github.com/muhammadahsan34898994/wp-installation-automation)

---

⭐ **If this project helped you, please give it a star!**
