#!/bin/bash

MYSQL=$(which mysql)
EXPECTED_ARGS=3

# Environment variables
DB_HOST="$NF_DATABASE_HOST"
DB_PORT="$NF_DATABASE_PORT"
DB_ADMIN_USERNAME="$NF_DATABASE_ADMIN_USERNAME"
DB_ADMIN_PASSWORD="$NF_DATABASE_ADMIN_PASSWORD"

database_exists() {
    result=$($MYSQL -h"$DB_HOST" -P"$DB_PORT" -u"$DB_ADMIN_USERNAME" -p"$DB_ADMIN_PASSWORD" -e "SHOW DATABASES LIKE '$1';" | grep "$1")
    [ -n "$result" ]
}

user_exists() {
    result=$($MYSQL -h"$DB_HOST" -P"$DB_PORT" -u"$DB_ADMIN_USERNAME" -p"$DB_ADMIN_PASSWORD" -e "SELECT user FROM mysql.user WHERE user='$1' AND host='%';" | grep "$1")
    [ -n "$result" ]
}

create_database() {
    if ! database_exists "$1"; then
        $MYSQL -h"$DB_HOST" -P"$DB_PORT" -u"$DB_ADMIN_USERNAME" -p"$DB_ADMIN_PASSWORD" -e "CREATE DATABASE $1;"
    else
        echo "Database '$1' already exists. Skipping creation."
    fi
}

create_user() {
    if ! user_exists "$1"; then
        $MYSQL -h"$DB_HOST" -P"$DB_PORT" -u"$DB_ADMIN_USERNAME" -p"$DB_ADMIN_PASSWORD" -e "CREATE USER '$1'@'%' IDENTIFIED BY '$2';"
    else
        echo "User '$1' already exists. Skipping creation."
    fi
}

grant_privileges() {
    $MYSQL -h"$DB_HOST" -P"$DB_PORT" -u"$DB_ADMIN_USERNAME" -p"$DB_ADMIN_PASSWORD" -e "GRANT ALL ON $1.* TO '$2'@'%';"
}

if [ $# -ne $EXPECTED_ARGS ]; then
    echo "Usage: nf-db [database_name] [database_user] [database_password]"
    exit 1
fi

echo "Creating database..."
create_database "$1"
echo "Database created successfully."

echo "Creating user and granting privileges..."
create_user "$2" "$3"
grant_privileges "$1" "$2"
echo "User created and privileges granted successfully."
