{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.shellAliases = {};

  environment.systemPackages = with pkgs; [
    bash-completion
    nix-bash-completions
    zsh-completions
    nix-zsh-completions

    tree
    ascii
    zsh-forgit
    cht-sh
    tealdeer
    parallel
    rlwrap
    haskellPackages.words
    datamash

    picocom
  ];

  programs = {
    bash = {
      shellAliases = {};
    };
    zsh = {
      enable = true;
      setOptions = [];
    };
  };
}
