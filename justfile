port := "1233"

[private]
@default:
    just --list --unsorted

# Run the development server.
dev: install
  pnpm exec vite --port {{port}} --clearScreen false

# Serve the output build and rebuild on changes. Useful to check on mobile.
serve: install build qr
  #!/usr/bin/env nu
  (interleave
    { pnpm exec vite preview --port {{port}} --clearScreen false --host }
    { watch ./src/ --debounce 1sec
      | where operation == "Write"
      | each { just build }
    }
  )

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

[private]
qr:
    #!/usr/bin/env nu
    let ip = sys net | where name == "en0" | get 0.ip | where protocol == "ipv4" | get 0.address
    let url = $"http://($ip):{{port}}"
    qrtool encode -t unicode $url
    print $url
