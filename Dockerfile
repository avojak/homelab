FROM ubuntu:20.04

ARG PACKER_VERSION=1.8.3

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        build-essential \
        ca-certificates \
        software-properties-common \
        tzdata \
        unzip \
        wget

# Install Packer
RUN wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -O /tmp/packer.zip && \
    unzip /tmp/packer.zip -d /usr/bin/

# Install VirtualBox
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian focal contrib" >> /etc/apt/sources.list && \
    wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | gpg --dearmor --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg && \
    apt-get update && apt-get install -y virtualbox-6.1

# Cleanup
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD [ "/bin/bash" ]