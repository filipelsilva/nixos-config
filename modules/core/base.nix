{ inputs, ... }:
let
  user = "filipe";
in
{
  flake.modules.nixos.core_base =
    { config, pkgs, ... }:
    let
      inherit (config.custom) userFullName;
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
        overlays = [
          (final: _prev: {
            stable = import inputs.nixpkgs-stable {
              inherit (final) system config;
            };
          })
          inputs.rust-overlay.overlays.default
          inputs.copyparty.overlays.default
        ];
      };

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };

      environment.systemPackages = [
        inputs.agenix.packages.x86_64-linux.default
      ];
      age.identityPaths = [ "/home/${user}/.ssh/id_ed25519" ];

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
        home.homeDirectory = "/home/${user}";
        home.stateVersion = config.system.stateVersion;
        programs.home-manager.enable = true;
      };
    };
}
