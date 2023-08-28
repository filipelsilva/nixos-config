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

    killall
    tree
    ascii
    zsh-forgit
    cht-sh
    tealdeer
    parallel
    rlwrap
    haskellPackages.words
    datamash
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
