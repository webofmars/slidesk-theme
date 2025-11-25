.PHONY: help

MAKEFLAGS += --silent
.DEFAULT_GOAL := help

help: ## Show help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[$$()% a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

include .env

start: ## Start application in dev mode
	docker run --rm -it \
		-v "$(CURDIR)":/slidesk \
		-w /slidesk/packages/slides \
		-p 1337:1337 \
		gouz/slidesk:latest \
		slidesk .

lint: ## Run linter
	$(call run_linter,)

lint-fix: ## Execute linting and fix
	$(call run_linter, \
		-e FIX_CSS=true \
		-e FIX_CSS_PRETTIER=true \
		-e FIX_JSON_PRETTIER=true \
		-e FIX_YAML_PRETTIER=true \
		-e FIX_MARKDOWN=true \
		-e FIX_MARKDOWN_PRETTIER=true \
		-e FIX_NATURAL_LANGUAGE=true \
	)

build: ## Build libs and applications
	rm -fr packages/slides/build
	$(call run_slidesk,--save build)
	cp packages/theme/hoverkraft.css packages/slides/build/hoverkraft.css

ci: ## Run CI checks
	$(MAKE) lint
	$(MAKE) build

define run_linter
	DEFAULT_WORKSPACE="$(CURDIR)"; \
	LINTER_IMAGE="linter:latest"; \
	VOLUME="$$DEFAULT_WORKSPACE:$$DEFAULT_WORKSPACE"; \
	docker build --build-arg UID=$(shell id -u) --build-arg GID=$(shell id -g) --tag $$LINTER_IMAGE .; \
	docker run \
		-e DEFAULT_WORKSPACE="$$DEFAULT_WORKSPACE" \
		-e FILTER_REGEX_INCLUDE="$(filter-out $@,$(MAKECMDGOALS))" \
		-e IGNORE_GITIGNORED_FILES=true \
		$(1) \
		-v $$VOLUME \
		--rm \
		$$LINTER_IMAGE
endef

define run_slidesk
	DEFAULT_WORKSPACE="$(CURDIR)"; \
	SLIDESK_IMAGE="gouz/slidesk:latest"; \
	VOLUME="$$DEFAULT_WORKSPACE:$$DEFAULT_WORKSPACE"; \
	docker run \
		-v $$VOLUME \
		-w $$DEFAULT_WORKSPACE/packages/slides \
		-u $(shell id -u):$(shell id -g) \
		--rm \
		$$SLIDESK_IMAGE \
		slidesk . \
		$(1) \
		$(filter-out $@,$(MAKECMDGOALS))
endef

#############################
# Argument fix workaround
#############################
%:
	@:
