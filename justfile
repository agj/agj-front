[private]
@default:
  just --list --unsorted

# Start a development shell, if you don't use direnv.
init:
  @echo "Use 'exit' to return to the regular shell."
  nix develop -c "$$SHELL"

# Run the development server.
dev: install
  pnpm exec parcel

# Build for release.
build: install
  rm -rf dist
  pnpm exec parcel build

# Update files that block AI crawlers.
update-ai-block:
  nu ./tasks/update-ai-block.nu

# Build and deploy.
deploy: build
  nu ./tasks/deploy.nu

[private]
install:
  pnpm install
