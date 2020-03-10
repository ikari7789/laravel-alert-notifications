#!/bin/bash

ILLUMINATE_VERSION=${ILLUMINATE_VERSION:-5.0.*}

ILLUMINATE_PACKAGES=(
    illuminate/support
)

function get_php_major_version() {
    local php_version=$1

    echo "${php_version}" | cut -d. -f1
}

function get_php_minor_version() {
    local php_version=$1

    echo "${php_version}" | cut -d. -f2
}

function get_php_release_version() {
    local php_version=$1

    echo "${php_version}" | cut -d. -f3
}

function get_php_version() {
    echo $(php -v | head -n1 | cut -d' ' -f2)
}

function get_php_version_int() {
    local php_version=$1

    local major_version=$(get_php_major_version "${php_version}")
    local minor_version=$(get_php_minor_version "${php_version}")
    local release_version=$(get_php_release_version "${php_version}")

    local version=$((${major_version} * 10000 + ${minor_version} * 100 + ${release_version}))

    echo "${version}"
}

php_version=$(get_php_version_int $(get_php_version))

# PHPUnit 5.0
if [ "${ILLUMINATE_VERSION}" = '5.0.*' ]; then
    if [ ${php_version} > 70200 ]; then
        pecl install mcrypt
    fi
    composer require "phpunit/phpunit:~5.0" --no-update --dev
fi

# Laravel 5.1 requirements
if [ "${ILLUMINATE_VERSION}" = '5.1.*' ]; then
    composer require "phpunit/phpunit:~5.0" --no-update --dev
fi

# Laravel 5.2 requirements
if [ "${ILLUMINATE_VERSION}" = '5.2.*' ]; then
    composer require "phpunit/phpunit:~5.0" --no-update --dev
fi

# Laravel 5.3 requirements
if [ "${ILLUMINATE_VERSION}" = '5.3.*' ]; then
    composer require "phpunit/phpunit:~5.0" --no-update --dev
fi

# Laravel 5.4 requirements
if [ "${ILLUMINATE_VERSION}" = '5.4.*' ]; then
    composer require "phpunit/phpunit:~5.0" --no-update --dev
fi

# Laravel 5.5 requirements
if [ "${ILLUMINATE_VERSION}" = '5.5.*' ]; then
    composer require "phpunit/phpunit:~6.0" --no-update --dev
    composer require "mockery/mockery:~1.0" --no-update --dev
fi

# Laravel 5.6 requirements
if [ "${ILLUMINATE_VERSION}" = '5.6.*' ]; then
    composer require "phpunit/phpunit:~7.0" --no-update --dev
    composer require "mockery/mockery:~1.0" --no-update --dev
fi

# Laravel 5.7 requirements
if [ "${ILLUMINATE_VERSION}" = '5.7.*' ]; then
    composer require "phpunit/phpunit:~7.0" --no-update --dev
    composer require "mockery/mockery:~1.0" --no-update --dev
fi

# Laravel 5.8 requirements
if [ "${ILLUMINATE_VERSION}" = '5.8.*' ]; then
    composer require "phpunit/phpunit:~7.0" --no-update --dev
    composer require "mockery/mockery:~1.0" --no-update --dev
    find ./tests -type f -exec sed -e 's/function setUp()/function setUp(): void/g' -i {} \;
fi

# Laravel 6.x requirements
if [ "${ILLUMINATE_VERSION}" = '6.*' ]; then
    composer require "phpunit/phpunit:~8.0" --no-update --dev
    composer require "mockery/mockery:~1.0" --no-update --dev
    find ./tests -type f -exec sed -e 's/function setUp()/function setUp(): void/g' -i {} \;
fi

# Laravel version sepecific requirements
for illuminate_package in "${ILLUMINATE_PACKAGES[@]}"; do
    composer require "${illuminate_package}:${ILLUMINATE_VERSION}" --no-update
done
