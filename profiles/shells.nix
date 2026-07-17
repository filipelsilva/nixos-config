{
  pkgs,
  lib,
  system,
  ...
}:
let
  isLinux = lib.hasSuffix "linux" system;
in
{
  imports = lib.optional isLinux {
    environment.shellAliases = { };

    programs.bash.shellAliases = { };

    programs.zsh.setOptions = [ ];
  };

  environment.systemPackages = with pkgs; [
    bash-completion
    nix-bash-completions
    zsh-completions
    nix-zsh-completions
  ];

  programs.zsh.enable = true;

  homeConfig =
    { config, ... }:
    {
      home.file = {
        ".inputrc".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/readline/.inputrc";
        ".zshrc".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/zsh/.zshrc";
      };
    };
}
