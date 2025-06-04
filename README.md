# SRBMiner-Multi-Docker
This project provides a Dockerized setup for [SRBMiner](https://github.com/doktor83/SRBMiner-Multi), making it easy to run the miner with your preferred pool, wallet, and worker name.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed
- [Docker Compose](https://docs.docker.com/compose/) installed

## Usage

### 1. Build the Docker Image

```bash
docker build -t srbminer:latest .
```

### 2. Auto-Configure Your Mining Setup

You can quickly set up your mining pool, wallet, and worker name using the provided script:

```bash
./configure_srbminer.sh
```

This will prompt you for your mining details and automatically generate a `docker-compose.yml` file.
> **Note:**
> The auto-configure script sets up SRBMiner for CPU mining by default.
> If you want to use GPU mining, you must edit `start_srbminer.sh` and adjust the GPU environment variables and settings as needed.

### 3. Start Mining

```bash
docker compose up -d
```

### 4. View Logs

```bash
docker compose logs -f srbminer
```

### 5. Stop Mining

```bash
docker compose down
```

## Customization

- To change mining parameters, edit the `command` section in `docker-compose.yml`.
- To adjust GPU environment variables, edit `start_srbminer.sh`.

## Example `docker-compose.yml`

```yaml
services:
  srbminer:
    image: srbminer:latest
    container_name: srbminer
    command: >
      --algorithm randomx
      --pool YOUR_MINING_POOL:YOUR_MINING_POOL_PORT
      --wallet YOUR_WALLET_ADDRESS.YOUR_WORKER_NAME
    restart: unless-stopped
```

## Example `configure_srbminer.sh`

```bash
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
```

## License

This project is for educational and personal use. Please respect the [SRBMiner license](https://github.com/doktor83/SRBMiner-Multi).
