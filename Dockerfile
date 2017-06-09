FROM centos:7

MAINTAINER Gabor Orosz "goro@goro.io"
ENV SALT_INSTALLER install-stack.sh
ENV SALT_USER salt
ENV SALT_GROUP salt

RUN curl -L http://bootstrap.saltstack.com -o $SALT_INSTALLER
RUN sh $SALT_INSTALLER -X -P -M
RUN rm $SALT_INSTALLER

RUN groupadd $SALT_GROUP
RUN adduser -m -s /sbin/nologin -g $SALT_GROUP $SALT_USER
RUN chown -R ${SALT_USER}:${SALT_GROUP} /etc/salt
RUN chown -R ${SALT_USER}:${SALT_GROUP} /var/cache/salt
RUN mkdir -p /var/run/salt
RUN chown -R ${SALT_USER}:${SALT_GROUP} /var/run/salt
RUN chown -R ${SALT_USER}:${SALT_GROUP} /var/log/salt

USER $SALT_USER
