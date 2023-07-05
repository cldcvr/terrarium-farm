.PHONY: clean_tf start-db harvest stop-db

TERRAFORM_DIR := ./terraform

clean_tf:
	rm -rf $(TERRAFORM_DIR)/.terraform
	rm -f $(TERRAFORM_DIR)/.terraform.lock.hcl

start-db:  ## Starts database in docker container
	docker compose up -d postgres

harvest:
	docker compose run --rm harvester

stop-db:  ## Stops and removes database container
	docker compose down
