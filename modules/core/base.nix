{ inputs, ... }:
{
  flake.modules.nixos.core_base =
    { config, pkgs, ... }:
    let
      inherit (config.custom) userFullName;
      user = config.custom.user;
    in
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        inputs.nix-index-database.nixosModules.nix-index
        inputs.agenix.nixosModules.default
        (inputs.nixpkgs.lib.mkAliasOptionModule [ "homeConfig" ] [ "home-manager" "users" user ])
        (inputs.nixpkgs.lib.mkAliasOptionModule [ "userConfig" ] [ "users" "users" user ])
      ];

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

      users.groups.${user} = { };
      users.groups.media = { };

      userConfig = {
        isNormalUser = true;
        initialPassword = "password";
        shell = pkgs.zsh;
        description = userFullName;
        group = user;
        extraGroups = [
          "wheel"
          "media"
        ];
      };

      homeConfig = {
        home.username = user;
        home.homeDirectory = config.custom.home;
        home.stateVersion = config.system.stateVersion;
        programs.home-manager.enable = true;
      };
    };
}
