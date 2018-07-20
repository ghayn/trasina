FROM ruby:2.5.1

RUN apt-get update

# DEBIAN_DPKGS BEGIN
RUN set -ex \
  && apt-get install -y --no-install-recommends ca-certificates curl git-core htop screen apt-transport-https vim bzip2 libfontconfig

# DEBIAN_DPKGS END

# SUPERVISOR BEGIN
RUN set -ex \
  && apt-get install -y --no-install-recommends supervisor \
  && mkdir -p /var/log/supervisor \
  && { \
    echo '[supervisord]'; \
    echo 'nodaemon=true'; \
  } >> /etc/supervisor/conf.d/supervisord.conf

# SUPERVISOR END

# SSH_SERVER BEGIN
RUN set -ex \
  && apt-get install -y --no-install-recommends openssh-server \
  && mkdir -p /var/run/sshd \
  && { \
    echo '[program:sshd]'; \
    echo 'command=/usr/sbin/sshd -D'; \
  } >> /etc/supervisor/conf.d/sshd.conf

# SSH_SERVER END

# CRON_SERVER BEGIN
RUN set -ex \
  && apt-get install -y --no-install-recommends cron \
  && { \
    echo '[program:cron]'; \
    echo 'command=/usr/sbin/cron -f'; \
  } >> /etc/supervisor/conf.d/cron.conf

# CRON_SERVER END

# NGINX_SERVER BEGIN
RUN echo "deb http://nginx.org/packages/debian/ $(awk -F"[)(]+" '/VERSION=/ {print $2}' /etc/os-release) nginx" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install --no-install-recommends --no-install-suggests -y --force-yes \
            ca-certificates \
            nginx \
  && { \
    echo '[program:nginx]'; \
    echo 'command=nginx -g "daemon off;"'; \
  } >> /etc/supervisor/conf.d/nginx.conf

# NGINX_SERVER END

# LOCALE BEGIN
RUN set -ex \
  && apt-get install -y --no-install-recommends locales \
  && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
  && locale-gen \
  && update-locale LANG=en_US.UTF-8 LANGUAGE=en_US:en:

ENV LC_ALL en_US.UTF-8

# LOCALE END

# TIMEZONE BEGIN
RUN set -ex \
  && echo "Asia/Shanghai" > /etc/timezone \
  && dpkg-reconfigure -f noninteractive tzdata

# TIMEZONE END

# SSH_AGENT BEGIN
RUN set -ex \
  && mkdir -p /root/.ssh /root/.bash.d \
  && { \
    echo 'Host *'; \
    echo 'ServerAliveInterval=15'; \
    echo 'ServerAliveCountMax=6'; \
    echo 'ForwardAgent yes'; \
  } >> /root/.ssh/config

# SSH_AGENT END

# DEBIAN_CLEAN BEGIN
RUN set -ex \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# DEBIAN_CLEAN END

# DOTBASHRC BEGIN
RUN set -ex \
  && { \
    echo "export TERM=xterm"; \
    echo "export PATH=$(echo $PATH)"; \
    echo "unset HISTFILE"; \
  } >> /root/.bashrc

# DOTBASHRC END

ENV EDITOR vim

RUN mkdir /app
WORKDIR /app
VOLUME /app

EXPOSE 22 80 3000

CMD ["sh", "-c", "env >> /etc/environment ; /usr/bin/supervisord"]
