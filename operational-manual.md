# Operational Manual

## Enterprise Cloud Architect – Mission 10

### 1. Project Overview

This project deploys a WordPress website and a MySQL database using Docker Compose on an Ubuntu Server virtual machine running in VirtualBox.

### 2. System Components

* **Host Machine:** Windows 11
* **Hypervisor:** VirtualBox
* **Operating System:** Ubuntu Server
* **Firewall:** UFW
* **Container Platform:** Docker Engine and Docker Compose
* **Web Application:** WordPress
* **Database:** MySQL 8.0

### 3. Accessing WordPress

1. Make sure the Ubuntu Server virtual machine is running.
2. Verify that the WordPress and MySQL containers are running.
3. Open a web browser on the host machine.
4. Visit `http://127.0.0.1:8080`.

### 4. Checking Docker Containers

Open the Ubuntu Server terminal and run:

```bash
docker ps
```

This command displays the running containers.

### 5. Managing Docker Compose

Navigate to the project directory:

```bash
cd ~/enterprise-cloud
```

Start the services:

```bash
docker compose up -d
```

Stop the services:

```bash
docker compose down
```

Check container status:

```bash
docker compose ps
```

### 6. Firewall Configuration

The UFW firewall is configured to allow SSH traffic on port 22 and web access on port 8080.

Check the firewall status:

```bash
sudo ufw status
```

### 7. Backup and Recovery

The backup script still requires troubleshooting and validation. Do not consider backups successful until a backup file has been generated and verified.

### 8. Troubleshooting

* If WordPress cannot be accessed, check whether the virtual machine and containers are running.
* If a container stops, inspect its logs using `docker logs CONTAINER_NAME`.
* If a service fails to start, inspect the Docker Compose configuration and service logs.

### 9. Maintenance

Regularly check container status, review logs, verify persistent storage, and test backups before relying on them.
