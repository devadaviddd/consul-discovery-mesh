FROM ubuntu:18.04

WORKDIR /home

COPY script.sh /home

RUN apt update -y --fix-missing && apt install wget -y

RUN --mount=type=cache,target=/var/cache/apt \
  apt install sudo && apt install net-tools && apt install gpg -y && apt-get install vim -y &&  apt-get install systemd -y &&  apt-get install nano


RUN apt-get update && apt-get install -y lsb-release && apt-get clean all

# Download the signing key to a new keyring
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Verify the key's fingerprint
RUN gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

# Add the HashiCorp repo
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

RUN sudo apt update && sudo apt install consul


RUN dpkg -l | grep systemd.

RUN --mount=type=cache,target=/var/cache/apt \
  apt-get install --reinstall systemd -y 

EXPOSE 8500

ENTRYPOINT [ "bash", "script.sh" ]