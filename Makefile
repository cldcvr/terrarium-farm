TERRAFORM_DIR := ./modules

POSTGRES_CONTAINER := postgres
POSTGRES_DB := cc_terrarium
POSTGRES_USER := postgres
FARM_DB_DUMP_FILE := $(POSTGRES_DB).psql

ifeq ($(FARM_VERSION),)
FARM_VERSION := latest
endif

.PHONY: clean_tf
clean_tf:
	rm -rf $(TERRAFORM_DIR)/.terraform
	rm -f $(TERRAFORM_DIR)/.terraform.lock.hcl

.PHONY: docker-init
docker-init:  ## Initialize the environment before running docker commands
	@touch ${HOME}/.netrc
ifneq (${GITHUB_TOKEN},)
	@echo "updating GitHub token in ${HOME}/.netrc"
	@sed -i.bak '/^machine github.com login/d' ${HOME}/.netrc
	@echo "machine github.com login x-access-token password ${GITHUB_TOKEN}" >> ${HOME}/.netrc
endif

.PHONY: start-db
start-db:  ## Starts database in docker container
	docker compose up -d postgres

.PHONY: db-dump
db-dump: start-db  ## Target for dumping PostgreSQL database to a file
	docker compose exec -T $(POSTGRES_CONTAINER) pg_dump --column-inserts -U $(POSTGRES_USER) -f /docker-entrypoint-initdb.d/$(FARM_DB_DUMP_FILE) -Fc $(POSTGRES_DB)

.PHONY: harvest
harvest:  ## Process the farm code and insert rows to database
	docker compose run --rm harvester

.PHONY: stop-db
stop-db:  ## Stops database container
	docker compose down

.PHONY: stop-db
stop-clean-db:  ## Stops database container, deletes db volume and the sql dump file
	docker compose down -v
	rm -f data/$(FARM_DB_DUMP_FILE)

data/$(FARM_DB_DUMP_FILE):
	$(call pull-release)

.PHONY: pull-release
pull-release:
	@echo "Downloading db dump from the latest terrarium-farm release..."
	@gh release download $(FARM_VERSION) --clobber -p 'terrarium_farm.psql' -O data/$(FARM_DB_DUMP_FILE)

.PHONY: help
help:
	@grep -hE '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
