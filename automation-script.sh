```bash
#!/bin/bash

# Mission 10 - Enterprise Cloud Architect
# Automated MySQL Database Backup Script

set -Eeuo pipefail

PROJECT_DIR="$HOME/enterprise-cloud"
BACKUP_DIR="$PROJECT_DIR/backups"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
BACKUP_FILE="$BACKUP_DIR/wordpress_backup_$TIMESTAMP.sql"

echo "Starting database backup..."

# Check Docker
if ! command -v docker >/dev/null 2>&1; then
    echo "ERROR: Docker is not installed."
    exit 1
fi

# Check Docker Compose
if ! docker compose version >/dev/null 2>&1; then
    echo "ERROR: Docker Compose is unavailable."
    exit 1
fi

# Check Compose file
if [ ! -f "$PROJECT_DIR/compose.yaml" ]; then
    echo "ERROR: compose.yaml was not found."
    exit 1
fi

# Prepare backup directory
mkdir -p "$BACKUP_DIR"
cd "$PROJECT_DIR"

# Confirm database service is running
if ! docker compose ps --status running --services | grep -qx "db"; then
    echo "ERROR: The database service is not running."
    exit 1
fi

# Create database backup using credentials inside the container
if ! docker compose exec -T db sh -c \
    'exec mysqldump --single-transaction -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE"' \
    > "$BACKUP_FILE"; then
    rm -f "$BACKUP_FILE"
    echo "ERROR: Database backup failed."
    exit 1
fi

# Verify backup file
if [ ! -s "$BACKUP_FILE" ]; then
    rm -f "$BACKUP_FILE"
    echo "ERROR: Backup file is empty."
    exit 1
fi

echo "Backup completed successfully!"
echo "Backup file: $BACKUP_FILE"
echo "Backup size: $(du -h "$BACKUP_FILE" | cut -f1)"
```
