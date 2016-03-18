FROM enil/alpine-supervisord

# Mailcatcher

RUN apk --update add ruby ruby-bundler ruby-irb ruby-json ruby-rake \
    ruby-bigdecimal ruby-io-console libstdc++ sqlite-libs openssl && \
    rm /var/cache/apk/*

ENV MAILCATCHER_VERSION=0.6.2

RUN apk --update add --virtual build-dependencies build-base ruby-dev openssl-dev sqlite-dev && \
    gem install --no-document mailcatcher -v ${MAILCATCHER_VERSION} && \
    apk del build-dependencies && \
    rm /var/cache/apk/*

EXPOSE 1025 1080

# Nginx

RUN apk add --update nginx apache2-utils && rm -rf /var/cache/apk/*
RUN mkdir -p /tmp/nginx/client-body

COPY config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY generate-credentials.sh /generate-credentials.sh

EXPOSE 80

# Supervisor

RUN mkdir -p /var/log/supervisor
COPY /config/supervisord/supervisord.conf /etc/supervisord.conf
COPY /config/supervisord/conf.d/* /etc/supervisor/conf.d/
