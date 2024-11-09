{
  description = "Flake for dark-notify";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    dark-notify = {
      url = "github:Mudada/dark-notify";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, dark-notify }:
    let 
      system = "aarch64-darwin";
      version = "0.1.2";
      pkgs = nixpkgs.legacyPackages.${system};
      manifest = (pkgs.lib.importTOML ./Cargo.toml).package;
    in {
      packages.${system}.default = pkgs.rustPlatform.buildRustPackage {
	pname = manifest.name;
    	version = manifest.version;
    	cargoLock.lockFile = ./Cargo.lock;
    	src = ./.;
	meta = {
	  description = "a program for watching when macOS switches to dark mode";
	  mainProgram = "dark-notify";
	};
      };
    };
}
