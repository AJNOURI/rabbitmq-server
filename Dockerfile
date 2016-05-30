FROM phusion/baseimage:0.9.16

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
RUN apt-get update && apt-get install -y wget vim
RUN wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | apt-key add -
RUN echo 'deb http://www.rabbitmq.com/debian/ testing main' | tee /etc/apt/sources.list.d/rabbitmq.list
RUN apt-get install -y vim rabbitmq-server
RUN rabbitmq-plugins enable rabbitmq_management
RUN service rabbitmq-server stop
ADD scripts /scripts
RUN chmod +x /scripts/*.sh
RUN touch /.firstrun

