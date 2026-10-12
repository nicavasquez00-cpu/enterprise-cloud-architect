# Operational Manual

## Enterprise Cloud Architect – Mission 10

CCM101 – Cloud Computing
Enterprise Cloud Architect – Operational Manual

Project: Enterprise Cloud Architect
Application Stack: WordPress + MySQL
Prepared by: Nica Vasquez | Justin Carl Anton | Joven Catungal | Kassandra Distor | Alleah Asenero
Section: BSIT 4H
Instructor: Jenkielyn C. Torres
Date: October 12, 2026

## 1. Project Overview

This project deploys a WordPress website and a MySQL database using Docker Compose on an Ubuntu Server virtual machine running in Oracle VirtualBox.

The purpose of this deployment is to demonstrate containerized application hosting, database integration, firewall configuration, persistent storage, and server maintenance.

This manual provides the client's IT team with instructions for deploying, accessing, securing, troubleshooting, and maintaining the system.

## 2. System Components

The project uses the following components:

* **Host Machine:** Windows 11
* **Hypervisor:** Oracle VirtualBox
* **Operating System:** Ubuntu Server
* **Firewall:** UFW (Uncomplicated Firewall)
* **Container Platform:** Docker Engine and Docker Compose
* **Web Application:** WordPress
* **Database:** MySQL 8.0
* **Project Directory:** `/home/group3/enterprise-cloud`
* **Website Address:** `http://127.0.0.1:8080`

## 3. Accessing WordPress

Follow these steps to access the deployed website:

1. Start the Ubuntu Server virtual machine in VirtualBox.

2. Log in to the Ubuntu Server account.

3. Open the terminal.

4. Navigate to the project directory:

   ```bash
   cd ~/enterprise-cloud
   ```

5. Verify that the containers are running:

   ```bash
   sudo docker compose ps
   ```

6. Open a web browser on the Windows host machine.

7. Visit:

   `http://127.0.0.1:8080`

The address uses port forwarding configured for the WordPress service.

### Figure 1. WordPress Website Verification

This screenshot shows the deployed WordPress website accessed through the host machine's web browser.

![Figure 1. WordPress website running on the host browser](![Deployment Verification](./screenshots/1.%20Deployment%20Verification.png)
)

## 4. Checking Docker Containers

Docker containers provide the runtime environment for WordPress and MySQL.

To list the running containers, execute:

```bash
sudo docker ps
```

To check the services managed by Docker Compose, execute:

```bash
cd ~/enterprise-cloud
sudo docker compose ps
```

The WordPress and MySQL services should show a running status when the deployment is operating normally.

If a container is not running, inspect its logs before attempting to restart it.

### Figure 2. Running Docker Containers

This screenshot documents the status of the WordPress and MySQL containers.

![Figure 2. Running Docker containers](![WordPress Website Deployment](![Security Configuration](![WordPress Website Deployment](./screenshots/2.%20Website%20Deployment.png)
)
)
)

## 5. Managing Docker Compose

Docker Compose manages the WordPress and MySQL services through the `compose.yaml` configuration file.

### 5.1 Navigate to the Project Directory

```bash
cd ~/enterprise-cloud
```

### 5.2 Start the Services

```bash
sudo docker compose up -d
```

This command creates and starts the services in the background according to the Compose configuration.

### 5.3 Check Service Status

```bash
sudo docker compose ps
```

### 5.4 View Service Logs

To inspect WordPress logs:

```bash
sudo docker compose logs --tail=50 wordpress
```

To inspect MySQL logs:

```bash
sudo docker compose logs --tail=50 db
```

### 5.5 Stop the Services

```bash
sudo docker compose stop
```

This stops the services without removing the containers.

To start stopped services again:

```bash
sudo docker compose start
```

**Important:** Avoid running `docker compose down -v` during routine maintenance because removing volumes can permanently delete persistent application and database data.

## 6. Firewall Configuration

The UFW firewall is configured to control incoming network traffic to the Ubuntu Server.

The project allows SSH access on port 22 and web access on port 8080.

### 6.1 Check Firewall Status

```bash
sudo ufw status verbose
```

Verify that the firewall is active and that the expected rules are present.

### 6.2 Review Firewall Rules

The current firewall configuration should allow only the services needed for the project.

* **Port 22/TCP:** SSH administration
* **Port 8080/TCP:** WordPress web access

Only enable additional ports when required. Avoid exposing the MySQL port directly to the public network.

### Figure 3. UFW Firewall Status

This screenshot documents the firewall status and configured rules.

![Figure 3. UFW firewall configuration](![Security Configuration](./screenshots/3.%20Security%20Configuration.png)
)

## 7. Persistent Storage

Docker volumes preserve application and database data independently of individual container lifecycles.

The project uses persistent volumes for:

* WordPress application files
* MySQL database files

### 7.1 List Docker Volumes

Execute:

```bash
sudo docker volume ls
```

Confirm that the project's WordPress and database volumes are present.

### 7.2 Inspect a Volume

To inspect a specific volume, use:

```bash
sudo docker volume inspect enterprise-cloud_wordpress_data
```

For the database volume:

```bash
sudo docker volume inspect enterprise-cloud_db_data
```

These commands display volume details, including the Docker-managed mount location.

Do not delete project volumes unless a verified backup exists and deletion is specifically intended.

### Figure 4. Persistent Docker Volumes

This screenshot shows the Docker volumes used for persistent WordPress and MySQL storage.

![Figure 4. Docker persistent volumes](![Persistent Storage](./screenshots/4.%20Persistent%20Storage.png)
)

## 8. Backup and Recovery

A database backup is important for disaster recovery and protection against accidental data loss.

The project contains a `backup.sh` script intended to perform a database backup. However, the script still requires troubleshooting and successful validation.

**Current limitation:** Do not consider the backup process operational until the script completes successfully and produces a valid backup file.

### 8.1 Verify Backup Files

After the backup script has been repaired and executed successfully, list the backup directory:

```bash
ls -lh ~/enterprise-cloud/backups
```

Confirm that a new SQL backup file exists and has a nonzero file size.

### 8.2 Recovery Considerations

Before restoring a database backup:

1. Identify the correct backup file.
2. Verify that the backup file is readable and valid.
3. Preserve a copy of the current database where possible.
4. Confirm the intended database and restoration procedure.
5. Perform restoration during an approved maintenance window.

Database restoration can overwrite existing data. Do not perform a restore operation without confirming the target database and backup file.

## 9. Troubleshooting and Maintenance

### 9.1 WordPress Website Is Not Accessible

Check the following:

1. Confirm that the Ubuntu Server virtual machine is running.

2. Check the Docker Compose services:

   ```bash
   sudo docker compose ps
   ```

3. Review the WordPress logs:

   ```bash
   sudo docker compose logs --tail=50 wordpress
   ```

4. Verify that port 8080 is configured correctly.

5. Confirm that the firewall allows the required web traffic.

### 9.2 MySQL Connection Problems

Check the database service status:

```bash
sudo docker compose ps
```

Inspect the database logs:

```bash
sudo docker compose logs --tail=50 db
```

Verify that the WordPress database host, database name, username, and credentials match the database configuration.

Do not repeatedly reset database passwords without checking the existing database configuration and persistent data.

### 9.3 Container Problems

If a service stops unexpectedly, inspect its logs before restarting it.

To restart the WordPress service:

```bash
sudo docker compose restart wordpress
```

To restart the database service:

```bash
sudo docker compose restart db
```

Restarting services may temporarily interrupt website access.

### 9.4 Routine Maintenance Checklist

Perform these maintenance tasks regularly:

* Check the status of Docker containers.
* Review application and database logs.
* Verify that the expected Docker volumes exist.
* Check firewall rules and remove unnecessary access.
* Keep Ubuntu Server and Docker components updated through an appropriate maintenance process.
* Validate the backup script and confirm that backup files can be read.
* Review configuration files before making changes.
* Avoid deleting containers or volumes without understanding the data-loss implications.

## 10. Security Recommendations

To protect the deployment:

* Use strong, unique database passwords.
* Do not publish actual credentials in a public GitHub repository.
* Store sensitive values in an appropriately protected environment file or secret-management mechanism.
* Restrict access to the Ubuntu Server account.
* Keep the firewall enabled and allow only necessary ports.
* Do not expose the MySQL service directly to the internet.
* Review logs and configuration changes regularly.
* Maintain verified backups before performing major maintenance.

The current deployment is intended for a laboratory environment. Additional security controls may be required before using the stack for a production business website.

## 11. GitHub Documentation Repository

The GitHub repository serves as the handover reference for the client's IT team.

It should contain:

* `README.md` — project overview and setup summary
* `operational-manual.md` — deployment, security, maintenance, and troubleshooting instructions
* `compose.yaml` — Docker Compose configuration used by the project
* `backup.sh` — database backup script, after it has been validated
* `final-reflection.md` — reflection covering Missions 1 through 10
* `screenshots/` — evidence of the deployed website, running containers, firewall configuration, persistent volumes, and GitHub documentation

### Figure 5. GitHub Documentation Repository

This screenshot should show the GitHub repository and its project documentation files.

![Figure 5. GitHub documentation repository](![Documentation on GitHub](./screenshots/5.%20Documentation%20on%20GitHub.png)
)

## 12. Operational Status and Limitations

The WordPress and MySQL services have been deployed using Docker Compose, and the WordPress website has been accessible through the host browser.

The project also includes firewall configuration and persistent Docker volumes.

The database backup script and automated scheduling still require validation before they can be considered fully operational. These items should be completed and tested before the deployment is treated as ready for disaster recovery.

## 13. Conclusion

This operational manual provides the basic procedures required to deploy, access, monitor, secure, and maintain the Enterprise Cloud Architect project.

The client's IT team should follow these procedures during routine operations and verify all backup and recovery processes before relying on them in a production environment.
