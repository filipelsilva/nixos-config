{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs: {
		defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

		homeConfigurations = {
			"filipe" = inputs.home-manager.lib.homeManagerConfiguration {
				system = "x86_64-linux";
				homeDirectory = "/home/filipe";
				username = "filipe";
				configuration.imports = [
					./home.nix
					./configuration.nix
					/etc/nixos/hardware-configuration.nix
				];
			};
		};
	};
}
