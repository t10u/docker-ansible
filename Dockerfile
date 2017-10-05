FROM debian:jessie-slim

LABEL maintainer="Toni Grigoriu <toni@grigoriu.ro>"

ENV TINI_VERSION 0.16.1

RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" |tee -a /etc/apt/sources.list.d/ansible.list && \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367 && \
apt-get update && \
apt-get -y install openssh-client ansible wget && \
wget -q https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}-amd64.deb && \
dpkg -i tini_${TINI_VERSION}-amd64.deb && \
rm -f tini_${TINI_VERSION}-amd64.deb

COPY docker-entrypoint.sh /docker-entrypoint.sh

COPY .ansible.cfg /root/.ansible.cfg

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["ansible"]

