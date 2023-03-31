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

    tree
    ascii
    zsh-forgit
    cht-sh
    tealdeer
    parallel
    rlwrap
    haskellPackages.words
    datamash

    xkeyboard_config # TODO check if this works with useXkbConfig
  ];

  programs = {
    zsh = {
      enable = true;
      setOptions = [];
    };
  };
}
