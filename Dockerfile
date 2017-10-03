FROM centos/systemd
ARG API_KEY=b4df00d
###
MAINTAINER "xyntrix@gmail.com"
ENV REDIS_VERSION 3.2.10-2
ENV API_KEY ${API_KEY}
###
RUN yum -y --setopt=tsflags=nodocs install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#RUN yum -y --setopt=tsflags=nodocs install chkconfig vim git screen net-tools iptables gcc gcc-c++ libxml2 libxml2-devel patch make initscripts jq
RUN yum -y --setopt=tsflags=nodocs install wget redis-${REDIS_VERSION}.el7
RUN wget -O /webapp.tar.gz https://s3-us-west-2.amazonaws.com/techops-interview-webapp/webapp.tar.gz
RUN tar xf /webapp.tar.gz
RUN rm -f /webapp.tar.gz
#RUN yum --setopt=tsflags=nodocs -y update; yum clean all
RUN printf 'API_KEY=%s' ${API_KEY} > /etc/sysconfig/webapp
RUN printf '[Unit]\n\
Description=webapp\n\
\n\
[Service]\n\
EnvironmentFile=-/etc/sysconfig/webapp\n\
ExecStart=/dist/example-webapp-linux\n\
WorkingDirectory=/\n\
Restart=always\n\
\n\
[Install]\n\
WantedBy=multi-user.target' > /lib/systemd/system/webapp.service
RUN systemctl enable webapp.service
RUN systemctl enable redis.service

EXPOSE 3000
CMD ["/usr/sbin/init"]
