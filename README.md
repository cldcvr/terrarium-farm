# terrarium-farm

This repo contains the various artifacts that are used to load the Terrarium "seed" database (an operation called "harvest"). As new artifacts are added, the tools here can be used to incrementally add new items to the databases (as well as start from an empty DB)

Terraform templates to be used for seeding should be placed in the ./terraform directory.

## Modes of Operation

### Local database

Use the `make start-db` command to start a local Postgres container where the database will be created on a docker volume.
These environment variables are required:

```sh
TR_DB_PASSWORD= # Choose a custom password. This variable is used by docker-compose to set password in postgres local server and is used in API to connect to the database
```

Then run "make harvest" to populate the local database.

### Remote database

In this mode, you are loading new information into a remote Postgres database - presumably a DB instance that is over a long period of time to facilitate Terrarium operation.

These environment variables are required:

```sh
TR_DB_HOST= # hostname of remote database instance
TR_DB_PORT= # port number (defaults to 5432)
TR_DB_SSL_MODE= # whether to use SSL Mode (defaults to 0)
TR_DB_USER= # user name
TR_DB_PASSWORD= # password
```

Then run "make harvest" to populate the remote database.

### Harvest Over Latest Release

To pull data-dump from the latest release, and run the harvest command on the existing data, use the following command:

1. Stop the current database and erase existing data.

    ```sh
    make stop-clean-db
    ```

2. Pull data-dump from the latest Terrarium release.

    ```sh
    make pull-release
    ```

3. Execute the harvest command to update the database.

    ```sh
    make harvest
    ```

Furthermore, to get a list of available make targets, use the command:

```sh
make help
```

## Prerequisite

- Golang >= 1.20
- Docker & Docker Compose
- GitHub CLI (gh)
