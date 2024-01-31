#!/bin/bash

MYSQL=$(which mysql)
MYSQLDUMP=$(which mysqldump)

database_exists() {
    result=$($MYSQL -h"$DB_HOST" -P"$DB_PORT" -u"$DB_ADMIN_USERNAME" -p"$DB_ADMIN_PASSWORD" -e "SHOW DATABASES LIKE '$1';" | grep "$1")
    [ -n "$result" ]
}

create_database() {
    if ! database_exists "$1"; then
        echo "Creating $1 database..."
        $MYSQL -h"$DB_HOST" -P"$DB_PORT" -u"$DB_ADMIN_USERNAME" -p"$DB_ADMIN_PASSWORD" -e "CREATE DATABASE $1;"
        echo "Database created successfully."
    else
        echo "Database '$1' already exists. Skipping creation."
    fi
}

grant_privileges() {
    echo "Granting privileges $2 to $1 database..."
    $MYSQL -h"$DB_HOST" -P"$DB_PORT" -u"$DB_ADMIN_USERNAME" -p"$DB_ADMIN_PASSWORD" -e "GRANT ALL ON $1.* TO '$2'@'%';"
    echo "Privileges granted successfully."
}

copy_database() {
    echo "Copying database $1 to $2..."
    $MYSQLDUMP -h"$DB_HOST" -P"$DB_PORT" -u"$DB_ADMIN_USERNAME" -p"$DB_ADMIN_PASSWORD" "$1" | $MYSQL -h"$DB_HOST" -P"$DB_PORT" -u"$DB_ADMIN_USERNAME" -p"$DB_ADMIN_PASSWORD" "$2"
    echo "Database copied successfully."
}

echo "Source database: $DB_SOURCE"
echo "Target database: $DB_NAME"

create_database "$DB_NAME"

grant_privileges "$DB_NAME" "$DB_USERNAME"

copy_database "$DB_SOURCE" "$DB_NAME"
