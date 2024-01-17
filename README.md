# Nortflank DB Setup Script (nf-db.sh)

This script streamlines the MySQL database configuration process, allowing you to create a new database, a user with a password, and grant all privileges to that user on the newly created database. It simplifies common tasks when working with MySQL databases in the Nortflank environment.

The script utilizes environment variables to configure the database connection, providing flexibility and customization.

### Features:

* Creation of a new MySQL database.
* Creation of a MySQL user with a password.
* Granting all privileges to the user on the database.

### Usage:
``` bash
./nf-db.sh db_name db_user db_pass
```

Ensure that the appropriate environment variables are configured before running the script.

### Requirements:

* MySQL installed and configured.
* Environment variables for the database connection (DB_HOST, DB_PORT, DB_ADMIN_USERNAME, DB_ADMIN_PASSWORD) must be defined.
 
This script is useful for streamlining the MySQL database setup process in the context of Nortflank, facilitating automation and deployment of applications relying on MySQL databases. Using English makes it more accessible for a wider audience to contribute and understand the script.
