FROM ubuntu:14.04

RUN apt-get update -y \
    && apt-get install -y \
    curl \
    unzip \
    ansible \
    python-pip

# install summon
RUN cd /tmp \
    && curl -L https://www.opscode.com/chef/install.sh | bash \
    && curl -sSL https://raw.githubusercontent.com/cyberark/summon/master/install.sh | bash 

# install terraform
RUN cd /tmp \
    && curl -O https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip \
    && unzip terraform_0.11.7_linux_amd64.zip \
    && mv terraform /usr/local/bin \
    && rm terraform*.zip

# create critical directories
RUN mkdir /var/chef \
    && mkdir /usr/local/lib/summon

COPY ./conjur_summon_provider.sh /usr/local/lib/summon/summon-conjur.sh

RUN echo "root:demo" | chpasswd		# set demo as root password

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

