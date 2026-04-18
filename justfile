[private]
@default:
    just --list --unsorted

# Run the development server.
dev:
  gleam run -m lustre/dev start

# Build for release.
build:
  gleam run -m lustre/dev build --minify

# Build and deploy.
deploy: build
  nu ./tasks/deploy.nu
