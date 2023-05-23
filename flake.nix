{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware";
    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    nixos-hardware,
    devenv,
    rust-overlay,
    ...
  } @ inputs: let
    extraConfig = {pkgs, ...}: {
      nixpkgs.overlays = [rust-overlay.overlays.default];
      _module.args.pkgs-stable = import inputs.nixpkgs-stable {
        config.allowUnfree = true;
        inherit (pkgs.stdenv.targetPlatform) system;
      };
    };
  in {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    nixosConfigurations = {
      Y540 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          extraConfig
          home-manager.nixosModules.home-manager
          ./hosts/Y540/configuration.nix
          nixos-hardware.nixosModules.lenovo-legion-y530-15ich
        ];
        specialArgs = {inherit inputs;};
      };
      guillotine = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          extraConfig
          home-manager.nixosModules.home-manager
          ./hosts/guillotine/configuration.nix
        ];
        specialArgs = {inherit inputs;};
      };
    };
  };
}
