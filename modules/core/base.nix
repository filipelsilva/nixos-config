{ inputs, ... }:
{
  flake.modules.nixos.core_base =
    { config, pkgs, ... }:
    let
      user = config.custom.user;
    in
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        inputs.nix-index-database.nixosModules.nix-index
        inputs.agenix.nixosModules.default
        config.flake.nixosUserModules.${user}
      ];

      system.stateVersion = "26.05";

      nixpkgs = {
        hostPlatform = "x86_64-linux";
        overlays = builtins.attrValues inputs.self.overlays;
      };

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${user} = config.flake.homeManagerModules.${user};
      };

      environment.systemPackages = [
        inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
      age.identityPaths = [ "${config.custom.home}/.ssh/id_ed25519" ];

      users.groups.media = { };
    };
}
