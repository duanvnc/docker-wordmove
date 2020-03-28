FROM ruby:alpine

LABEL maintainers.1="Simon Bland <simon.bland@bluewin.ch>"
LABEL maintainers.2="Alessandro Fazzi <alessandro.fazzi@welaika.com>"

ENV WORDMOVE_WORKDIR /html

COPY mount-ssh.sh /bin/mount-ssh.sh
RUN chmod +x /bin/mount-ssh.sh

RUN apk update && \
      apk add --no-cache openssh curl rsync mysql-client bash \
                     php7-mysqli php7-phar php7-json php7-mbstring

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
      chmod +x wp-cli.phar && \
      mv wp-cli.phar /usr/local/bin/wp

RUN gem install wordmove --version 5.0.2

WORKDIR ${WORDMOVE_WORKDIR}

ENTRYPOINT ["/bin/mount-ssh.sh"]

CMD ["/bin/bash"]
