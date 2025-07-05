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

# Build and deploy.
deploy: build
  nu ./scripts/deploy.nu

[private]
install:
  pnpm install
