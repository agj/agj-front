
init: ## Start a development shell, if you don't use direnv.
	@echo "Use 'exit' to return to the regular shell."
	nix develop -c $$SHELL

dev: install ## Run the development server.
	npx parcel

build: install ## Build for release.
	rm -rf dist
	npx parcel build

deploy: build ## Build and deploy.
	nu ./scripts/deploy.nu

install: ## Only install dependencies.
	pnpm install



# The following makes this file self-documenting.
# See: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
