{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    bash
    bash-completion
    nix-bash-completions
    zsh
    zsh-completions
    nix-zsh-completions
    zsh-forgit
  ];
  programs = {
    zsh = {
      enable = true;
      setOptions = [];
    };
  };
}
