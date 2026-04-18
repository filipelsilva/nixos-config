{ inputs, ... }:
{
  flake.modules.nixos.core_base =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      import-lib = import ../lib/_lib.nix { inherit lib; };
      userModules = import-lib.discoverModules ../users;
    in
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        inputs.nix-index-database.nixosModules.nix-index
        inputs.agenix.nixosModules.default
      ]
      ++ builtins.attrValues (
        lib.mapAttrs (name: path: (import path { }).flake.modules.nixos.${name}) userModules
      );

      system.stateVersion = "26.05";

      nixpkgs = {
        hostPlatform = "x86_64-linux";
        overlays = builtins.attrValues inputs.self.overlays;
      };

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };

      environment.systemPackages = [
        inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
      age.identityPaths = [ "${config.custom.home}/.ssh/id_ed25519" ];

      users.groups.media = { };
    };
}
