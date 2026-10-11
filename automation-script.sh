#!/bin/bash

# Mission 10 - Enterprise Cloud Architect

# Group backup automation script

# Status: Requires testing and validation

set -euo pipefail

PROJECT_DIR="$HOME/enterprise-cloud"
BACKUP_DIR="$PROJECT_DIR/backups"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"

echo "Starting backup preparation..."

if ! command -v docker >/dev/null 2>&1; then
echo "ERROR: Docker is not installed or not available."
exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
echo "ERROR: Docker Compose is not available."
exit 1
fi

if [ ! -f "$PROJECT_DIR/compose.yaml" ]; then
echo "ERROR: compose.yaml was not found in $PROJECT_DIR."
exit 1
fi

mkdir -p "$BACKUP_DIR"

cd "$PROJECT_DIR"

if ! docker compose ps --status running --services | grep -qx "db"; then
echo "ERROR: The database service is not running."
exit 1
fi

echo "Checks passed. Database backup has not yet been performed."
echo "Configure and test the database dump command before relying on this script."
exit 2
