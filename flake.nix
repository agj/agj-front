{
  description = "agj.cl front";

  inputs = {
    # Temporary, to get elm-format fixed early.
    # https://nixpk.gs/pr-tracker.html?pr=419302
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
            pkgs.elmPackages.elm
            pkgs.elmPackages.elm-format
            pkgs.elmPackages.elm-json
            pkgs.elmPackages.elm-test
            pkgs.just
            pkgs.nodePackages.pnpm
            pkgs.nodePackages.prettier
            pkgs.nodejs-slim_20
            pkgs.nushell
          ];
        };
      }
    );
}
