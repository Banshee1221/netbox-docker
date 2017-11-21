# Base Image
FROM ubuntu:xenial

# Metadata
LABEL base.image="ubuntu:xenial"
LABEL software="Netbox"
LABEL software.version="2.2.6"
LABEL description="IP address management (IPAM) and data center infrastructure management (DCIM) tool. "
LABEL website="https://github.com/digitalocean/netbox"
LABEL documentation="https://netbox.readthedocs.io/en/stable/"
LABEL license="https://github.com/digitalocean/netbox/blob/develop/LICENSE.txt"
LABEL tags="Netbox IPAM DCIM"

# Maintainer
MAINTAINER Eugene de Beste <debeste.eugene@gmail.com>

ENV ver "2.2.6"
ENV url "https://github.com/digitalocean/netbox/archive/v$ver.tar.gz"

RUN apt update && apt install -y \
	python3 \
	python3-dev \
	python3-setuptools \
	build-essential \
	libxml2-dev \
	libxslt1-dev \
	libffi-dev \
	graphviz \
	libpq-dev \
	libssl-dev \
	zlib1g-dev \
	python3-pip \
	wget \
	nginx

RUN pip3 install --upgrade pip

RUN wget $url -P /opt && \
	tar -xzf /opt/v$ver.tar.gz -C /opt && \
	ln -s /opt/netbox-$ver/ /opt/netbox && \
	cd /opt/netbox && pip3 install -r requirements.txt && \
	cp netbox/netbox/configuration.example.py netbox/netbox/configuration.py

COPY startup.sh /opt/netbox/netbox/startup.sh

EXPOSE 8000

ENTRYPOINT ["/bin/bash", "/opt/netbox/netbox/startup.sh"]
