{ ... }:
{
  flake.modules.nixos.core_multiplexer =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      programs.tmux.enable = true;

      environment.systemPackages = with pkgs; [
        screen
      ];

      home-manager.users = config.flake.customDefaults.forAllUsers (lib.attrNames config.custom.users) (
        user:
        { config, ... }:
        {
          home.packages = [
            (pkgs.writeShellScriptBin "tms" (
              builtins.readFile "${config.home.homeDirectory}/dotfiles/scripts/tmux-sessionizer.sh"
            ))
          ];
          home.file = {
            ".screenrc".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/screen/.screenrc";
            ".tmux.conf".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/tmux/.tmux.conf";
          };
        }
      );
    };
}
