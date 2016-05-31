FROM phusion/baseimage:0.9.16

# Thanks to: frodenas/docker-ubuntu



# Install utilities
RUN locale-gen en_US.UTF-8 && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale && \
    sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --force-yes \
    build-essential \
    software-properties-common \
    apt-transport-https \
    curl \
    wget \
    git \
    unzip \
    pwgen \
    ethtool

# Use baseimage-docker's init system.
CMD ["/sbin/my_init","/bin/bash"]
RUN apt-get update && apt-get install -y wget vim
RUN wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | apt-key add -
RUN echo 'deb http://www.rabbitmq.com/debian/ testing main' | tee /etc/apt/sources.list.d/rabbitmq.list
RUN apt-get install -y vim rabbitmq-server
RUN rabbitmq-plugins enable rabbitmq_management
RUN usermod -m -d /var/lib/rabbitmq rabbitmq
RUN service rabbitmq-server stop
ADD scripts /scripts
RUN chmod +x /scripts/*.sh
RUN touch /.firstrun

