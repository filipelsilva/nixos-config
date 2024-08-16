{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    nixos-hardware,
    rust-overlay,
    alejandra,
    ...
  } @ inputs: let
    user = "filipe";
    userFullName = "Filipe Ligeiro Silva";

    extraConfig = {pkgs, ...}: {
      _module.args.pkgs-stable = import nixpkgs-stable {
        config.allowUnfree = true;
        inherit (pkgs.stdenv.targetPlatform) system;
      };
      nixpkgs.overlays = [rust-overlay.overlays.default];
    };

    mkHost = hostname: {
      system ? "x86_64-linux",
      headless ? false,
      extraModules ? [],
      extraArgs ? {},
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules =
          [
            extraConfig
            ./hosts/${hostname}/configuration.nix
            {
              system.stateVersion = "23.11";
              networking.hostName = hostname;
            }
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
              };
            }
          ]
          ++ extraModules;
        specialArgs =
          {
            inherit inputs headless user userFullName;
          }
          // extraArgs;
      };
  in {
    formatter.x86_64-linux = alejandra.defaultPackage.x86_64-linux;

    nixosConfigurations = {
      Y540 = mkHost "Y540" {
        extraModules = [nixos-hardware.nixosModules.lenovo-legion-y530-15ich];
      };
      T490 = mkHost "T490" {
        extraModules = [nixos-hardware.nixosModules.lenovo-thinkpad-t490];
      };
      N100 = mkHost "N100" {
        headless = true;
      };
    };
  };
}
