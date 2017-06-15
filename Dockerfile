FROM centos:7

MAINTAINER Gabor Orosz "goro@goro.io"
ENV SALT_INSTALLER install-stack.sh
ENV SALT_USER salt
ENV SALT_GROUP salt

RUN curl -L http://bootstrap.saltstack.com -o $SALT_INSTALLER \
 && sh $SALT_INSTALLER -X -P -M \
 && rm $SALT_INSTALLER

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

USER $SALT_USER

EXPOSE 4505 4506
