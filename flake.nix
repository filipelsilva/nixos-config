{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    devenv.url = "github:cachix/devenv";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    nixos-hardware,
    devenv,
    utils,
    ...
  } @ inputs: let
    otherChannels = {pkgs, ...}: {
      _module.args.pkgs-stable = import inputs.nixpkgs-stable {inherit (pkgs.stdenv.targetPlatform) system;};
    };
  in {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    nixosConfigurations = {
      Y540 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          otherChannels
          ./hosts/Y540/configuration.nix
          home-manager.nixosModules.home-manager
          nixos-hardware.nixosModules.lenovo-legion-y530-15ich
        ];
        specialArgs = {inherit inputs;};
      };
      guillotine = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          otherChannels
          ./hosts/guillotine/configuration.nix
          home-manager.nixosModules.home-manager
        ];
        specialArgs = {inherit inputs;};
      };
    };
  };
}
