FROM centos:7

MAINTAINER Gabor Orosz "goro@goro.io"
ENV SALT_INSTALLER install-stack.sh
ENV SALT_USER salt
ENV SALT_GROUP salt
ENV container docker

# Update repository caches
RUN yum -y update \
 && yum clean all

# Install and tune systemd
RUN yum -y install systemd \
 && yum clean all \
 && (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done) \
 && rm -f /lib/systemd/system/multi-user.target.wants/* \
 && rm -f /etc/systemd/system/*.wants/* \
 && rm -f /lib/systemd/system/local-fs.target.wants/* \
 && rm -f /lib/systemd/system/sockets.target.wants/*udev* \
 && rm -f /lib/systemd/system/sockets.target.wants/*initctl* \
 && rm -f /lib/systemd/system/basic.target.wants/* \
 && rm -f /lib/systemd/system/anaconda.target.wants/*

# Install SaltStack
RUN curl -L http://bootstrap.saltstack.com -o $SALT_INSTALLER \
 && sh $SALT_INSTALLER -X -P -M \
 && rm $SALT_INSTALLER

# Configure SaltStack
RUN groupadd $SALT_GROUP \
 && adduser -m -s /bin/bash -g $SALT_GROUP $SALT_USER \
 && sed -i 's/#user: root/user: salt/g' /etc/salt/master\
 && mkdir -p /var/run/salt \
 && mkdir -p /srv/salt \
 && chown -R ${SALT_USER}:${SALT_GROUP} /etc/salt \
 && chown -R ${SALT_USER}:${SALT_GROUP} /var/cache/salt \
 && chown -R ${SALT_USER}:${SALT_GROUP} /var/run/salt \
 && chown -R ${SALT_USER}:${SALT_GROUP} /var/log/salt \
 && chown -R ${SALT_USER}:${SALT_GROUP} /srv/salt \
 && yum -y install sudo \
 && echo 'salt    ALL=(ALL)       NOPASSWD:ALL' > /etc/sudoers.d/salt

VOLUME [ "/sys/fs/cgroup" ]
EXPOSE 4505 4506
COPY entrypoint.sh /
WORKDIR /
ENTRYPOINT [ "/entrypoint.sh" ]
