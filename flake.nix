{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs2211.url = "github:nixos/nixpkgs/nixos-22.11";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs2211,
    nixos-hardware,
    home-manager,
    utils,
    ...
  } @ inputs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    nixosConfigurations = {
      Y540 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/Y540/configuration.nix
          home-manager.nixosModules.home-manager
        ];
        specialArgs = {inherit inputs;};
      };
      dsi = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/dsi/configuration.nix
          home-manager.nixosModules.home-manager
        ];
        specialArgs = {inherit inputs;};
      };
      guillotine = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/guillotine/configuration.nix
          home-manager.nixosModules.home-manager
        ];
        specialArgs = {inherit inputs;};
      };
    };
  };
}
