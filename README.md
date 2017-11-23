[![GitHub release](https://img.shields.io/github/release/digitalocean/netbox.svg)]() [![Docker Build Status](https://img.shields.io/docker/build/eugenedb/netbox-docker.svg)]()
# Netbox Docker

Netbox is an [IPAM and DCIM management tool](https://github.com/digitalocean/netbox) by Digital Ocean. This is a containerized version of said tool.

## Usage

- Either have an existing, or create a new PostgreSQL database instance and create a table for Netbox.
- Edit the environment file, `env`, to reflect your environment.
Then, either:
- Manual build:
  - ```bash
    git clone https://github.com/Banshee1221/netbox-docker.git
    cd netbox-docker
    docker build -t netbox-docker .
    docker run -d -p <port to listen on host>:8000 --env-file=env netbox-docker
    ```
- Docker Hub:
  - `docker run -d -p <port to listen on host>:8000 --env-file=env eugenedb/netbox`

## Example env file

```bash
ADMIN_USER=admin
ADMIN_EMAIL=admin@local.net
ADMIN_PASS=123qwe

ALLOWED_HOSTS='localhost', '127.0.0.1'
NGINX_HOST=same_as_FQDN_for_allowed_hosts

DB_USER=netbox
DB_NAME=netbox
DB_PASS=super_secret_password
DB_HOST=127.0.0.1
DB_PORT=5432
```
