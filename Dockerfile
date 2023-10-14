FROM webdevops/php-nginx-dev:8.2

LABEL org.opencontainers.image.source=https://github.com/php-base/php

RUN apt update \
    # Core PHP modules
    && apt install -y --no-install-recommends libicu-dev libxml2-dev libjpeg62-turbo-dev libbz2-dev zlib1g-dev libc-client-dev libmagickwand-dev libxslt-dev libzip-dev mariadb-client libonig-dev \
    && docker-php-ext-install pdo_mysql intl mbstring soap bz2 zip bcmath gd xsl calendar opcache gettext sockets \
    # Install additional apps
    && apt install -y --no-install-recommends git nano less wget \
    # Install composer
    && curl -sS https://getcomposer.org/installer | php -- --quiet --install-dir=/usr/local/bin --filename=composer

# Install NodeJS and npm
RUN apt install -y ca-certificates curl gnupg \
    &&  mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && NODE_MAJOR=18 \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt update \
    && apt install -y nodejs


COPY files/php.ini  /opt/docker/etc/php/

WORKDIR /app
