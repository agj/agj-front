port := "1233"

[private]
@default:
    just --list --unsorted

# Run the development server.
dev: install
  pnpm exec vite --port {{port}} --clearScreen false --host

# Build for release.
build: install
  rm -rf ./dist/
  pnpm exec vite build --base ./

# Build and deploy.
deploy: build
  nu ./tasks/deploy.nu

[private]
install:
  pnpm install
