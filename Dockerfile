FROM php:8.0-cli-alpine

LABEL maintainer="Oleg Tikhonov <to@toro.one>"
LABEL name="php-registry-cli"

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/

RUN apk add --no-cache \
    git \
    zip

# PHP configuration

COPY ./docker/php/php.ini "${PHP_INI_DIR}"/php.ini

# Composer

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --2 --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

# Working directory

RUN adduser --home /usr/lib/registry --disable-password --uid 1001 --shell /bin/ash registry

USER registry

WORKDIR /usr/lib/registry

COPY --chown=registry composer.json composer.lock ./

RUN composer check-platform-reqs \
    && composer install --no-dev

# Project files

COPY --chown=registry bin/ ./bin
COPY --chown=registry src/ ./src
RUN chmod -R +x /usr/lib/registry/bin

ENTRYPOINT ["/usr/lib/registry/bin/cli"]
