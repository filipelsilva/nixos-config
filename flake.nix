{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs@{ self, nixpkgs, home-manager, ...  }:
	let
		lib = nixpkgs.lib;
		system = "x86_64-linux";
	in
	{
		nixosConfigurations = {
			Y540 = lib.nixosSystem {
				inherit system;
				modules = [
					./hosts/Y540/configuration.nix
						home-manager.nixosModules.home-manager {
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.users = {
								filipe = import ./hosts/home.nix;
							};
						}
				];
				specialArgs = { inherit inputs; };
			};
			dsi = lib.nixosSystem {
				inherit system;
				modules = [
					./hosts/dsi/configuration.nix
						home-manager.nixosModules.home-manager {
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.users = {
								filipe = import ./hosts/home.nix;
							};
						}
				];
				specialArgs = { inherit inputs; };
			};
		};
	};
}
