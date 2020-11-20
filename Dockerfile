#
# Wordmove Dockerfile
#

# Pull base image.
FROM ruby:2.6-slim

LABEL maintainers.1="Simon Bland <simon.bland@bluewin.ch>"
LABEL maintainers.2="Alessandro Fazzi <alessandro.fazzi@welaika.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV WORDMOVE_WORKDIR /var/www/html

COPY mount-ssh.sh /bin/mount-ssh.sh
RUN chmod +x /bin/mount-ssh.sh

RUN apt-get update && apt-get install -y \
  openssh-server \
  curl \
  rsync \
  php-cli \
  php-mysql \
  mariadb-client \
  lftp \
  php-simplexml \
  php-curl

RUN gem install wordmove --version 5.0.2
RUN curl -o /usr/local/bin/wp -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x /usr/local/bin/wp

WORKDIR ${WORDMOVE_WORKDIR}

ENTRYPOINT ["/bin/mount-ssh.sh"]

CMD ["/bin/bash", "-l"]
