{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
      in
      {
        devShells.default = pkgs.mkShell {
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.openssl ];
          packages = [
            pkgs.pkg-config
            pkgs.openssl.dev
            pkgs.openssl
            pkgs.cargo
            pkgs.rustc
            pkgs.clippy
            pkgs.rust-analyzer
            pkgs.rustfmt
            pkgs.cargo-tarpaulin
            pkgs.cargo-udeps
            pkgs.cargo-edit
            pkgs.mold
            pkgs.sqlx-cli
            pkgs.postgresql_17
          ];
        };
      });
}
