{
  inputs = {
    # Temporarily on master due to Nushell issue.
    # See: https://github.com/NixOS/nixpkgs/issues/510488
    # See: https://nixpk.gs/pr-tracker.html?pr=510439
    nixpkgs.url = "github:nixos/nixpkgs/master";
    # nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {system = system;};
      in {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.beam28Packages.erlang
            pkgs.beam28Packages.rebar3
            pkgs.gleam
            pkgs.just
            pkgs.nodejs-slim_24
            pkgs.nushell
            pkgs.pnpm
            pkgs.prettier
          ];
        };
      }
    );
}
