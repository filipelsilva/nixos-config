{ ... }:
{
  flake.modules.nixos.core_shells =
    { config, pkgs, ... }:
    {
      environment.shellAliases = { };

      environment.systemPackages = with pkgs; [
        bash-completion
        nix-bash-completions
        zsh-completions
        nix-zsh-completions
      ];

      programs = {
        bash = {
          shellAliases = { };
        };
        zsh = {
          enable = true;
          setOptions = [ ];
        };
      };

      home-manager.users.${config.custom.user} =
        { config, ... }:
        {
          home.file = {
            ".inputrc".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/readline/.inputrc";
            ".zshrc".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/zsh/.zshrc";
          };
        };
    };
}
