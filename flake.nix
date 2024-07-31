{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
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
    extraConfig = {pkgs, ...}: {
      nixpkgs.overlays = [rust-overlay.overlays.default];
      _module.args.pkgs-stable = import nixpkgs-stable {
        config.allowUnfree = true;
        inherit (pkgs.stdenv.targetPlatform) system;
      };
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
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs headless;
                  nixosConfig = self;
                };
              };
            }
            ./hosts/${hostname}/configuration.nix
            {networking.hostName = hostname;}
          ]
          ++ extraModules;
        specialArgs =
          {
            inherit inputs headless;
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
