# Terrarium Farm

This repo contains the various artifacts that are used to load the Terrarium "seed" database (an operation called "harvest"). As new artifacts are added, the tools here can be used to incrementally add new items to the databases (as well as start from an empty DB)

Artifacts that are added to the farm:

1. Terraform Module references - `./modules.yaml`
2. Dependency interfaces - `./dependencies/*.yaml`
3. Platform references - `./platform/*.yaml`

The artifacts managed in this repo are consumed by the Terrarium tools at <https://github.com/cldcvr/terrarium>.

## What is Harvest

The precess of computing the provided YAML artifacts in farm and populating the Terrarium database with findings is called the Harvesting process in Terrarium.

Artifacts and it's harvesting process:

1. Terraform Module references

    The module references given in this YAML file are used to populate following tables in Terrarium - tf_providers, tf_resource_types, tf_resource_attributes, tf_module_attributes, and tf_resource_attribute_mappings.

    This enables Terrarium to build a index of relation between the given modules by the module attributes.

    In order to harvest the modules, the process downloads tf code of each module, parses it and indexes it into a SQL database.

2. Dependency interfaces

    The dependency interfaces given in these YAML files are parsed and used to populate the dependencies and dependency_attributes tables in the Terrarium DB.

    This data is utilized by the Terrarium tools to help platform engineers implement the dependency in the platform template. And it also help the users in referencing the dependencies correctly into their apps.

3. Platform references

    References of the readily available platform templates helps populate the platforms and the platform_components table in the Terrarium DB.

    This enables Terrarium to build a index of relation between the dependencies implemented across different platform templates.

    In order to harvest the platforms, the process downloads the terrarium platform manifest files for each platform reference, and tries to relate the the implemented components with the Dependency interfaces data to make sure the implementation in platform matches the interface.

## Data Dump

After harvesting all the farm artifacts into DB, we take a DB dump to preserve the findings such that, a new user doesn't have to run the entire harvest process and can directly use the data dump.

As a release process of this Terrarium Farm repository, we upload a harvested data dump to each release as assets.

## Update CLI with latest Farm data dump

Terrarium CLI uses the harvested data intensively to perform a lot actions. Therefore, the CLI users must ensure updating the farm data time to time.

Following command in the CLI can be used to download data dump from the latest release in the farm repo, and apply it on the local terrarium database (default SQLite).

```sh
rm ~/.terrarium/farm.sqlite # Only needed if the CLI already has data.
terrarium farm update
```

## Run harvest program

1. Setup access to private repos

    ```sh
    GITHUB_TOKEN=<token> make docker-init
    ```

2. Setup DB connection

   There are two modes of running the database, use one of these:

    - Local database

        Start a local Postgres container where the database will be created on a docker volume.

        ```sh
        export TR_DB_PASSWORD= # Choose a custom password. This variable is used by docker-compose to set password in postgres local server and is used in API to connect to the database

        make start-db
        ```

        (either export or put it in `.env`)

    - Remote database

        In this mode, you are loading new information into a remote Postgres database - presumably a DB instance that is over a long period of time to facilitate Terrarium operation.

        These environment variables are required:

        ```sh
        TR_DB_HOST= # hostname of remote database instance
        TR_DB_PORT= # port number (defaults to 5432)
        TR_DB_SSL_MODE= # whether to use SSL Mode (defaults to 0)
        TR_DB_USER= # user name
        TR_DB_PASSWORD= # password
        ```

3. Run harvest target

    ```sh
    make harvest
    ```

## Harvest over existing data

As the harvest process computes artifacts and writes database, it produces unique uuid for each row being inserted. In cases where some new artifacts are added to existing farm, we won't want to regenerate the already existing UUIDs and would want the harvest process to update or append data instead.

The Harvest process is idempotent i.e. built to not overwrite the existing data if any.

In order to run the harvest process over current latest release of the farm repo, use the following command:

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
