#!/bin/bash

echo "=============================================="
echo "  SRBMiner Docker Auto-Configurator"
echo "=============================================="
echo "INFO: This configuration is set up for CPU mining."
echo "      If you want to use GPU mining, you will need"
echo "      to edit start_srbminer.sh and adjust GPU settings."
echo "----------------------------------------------"

# Prompt for user input
read -p "Enter mining pool (e.g. ca-tarirx.luckypool.io:9118): " POOL
read -p "Enter wallet address: " WALLET
read -p "Enter worker name: " WORKER

# Update docker-compose.yml
cat > docker-compose.yml <<EOF
services:
  srbminer:
    image: srbminer:latest
    container_name: srbminer
    command:
      --algorithm randomx
      --pool $POOL
      --wallet $WALLET.$WORKER
    restart: unless-stopped
EOF

echo "docker-compose.yml has been configured!"