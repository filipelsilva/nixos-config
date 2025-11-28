{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pwndbg = {
      url = "github:pwndbg/pwndbg";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    nixos-hardware,
    nix-index-database,
    agenix,
    alejandra,
    rust-overlay,
    winapps,
    ...
  } @ inputs: let
    user = "filipe";
    userFullName = "Filipe Ligeiro Silva";

    mkHost = hostname: {
      system ? "x86_64-linux",
      headless ? false,
      extraModules ? [],
      extraArgs ? {},
    }:
      nixpkgs.lib.nixosSystem {
        modules =
          [
            ./hosts/${hostname}/configuration.nix
            home-manager.nixosModules.home-manager
            nix-index-database.nixosModules.nix-index
            agenix.nixosModules.default
            {
              system.stateVersion = "23.11";
              networking.hostName = hostname;

              nixpkgs = {
                hostPlatform = system;
                overlays = [
                  (final: _prev: {
                    stable = import nixpkgs-stable {
                      inherit (final) system config;
                    };
                  })
                  rust-overlay.overlays.default
                ];
              };

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
              };

              environment.systemPackages = [agenix.packages.${system}.default];
              age.identityPaths = ["/home/${user}/.ssh/id_ed25519"];
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
        extraArgs = {
          dataPool = rec {
            name = "data";
            location = "/mnt/${name}";
            drives = [
              "/dev/disk/by-id/ata-ST8000VN004-3CP101_WRQ01QF2"
              "/dev/disk/by-id/ata-ST8000VN004-3CP101_WWZ3T73R"
            ];
          };
        };
      };
    };
  };
}
