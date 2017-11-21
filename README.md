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

## TODO

Add Nginx instead of using built-in webserver
