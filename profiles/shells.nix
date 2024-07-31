{pkgs, ...}: {
  environment.shellAliases = {};

  environment.systemPackages = with pkgs; [
    bash-completion
    nix-bash-completions
    zsh-completions
    nix-zsh-completions

    tree
    ascii
    cht-sh
    tealdeer
    (lib.hiPrio parallel)
    haskellPackages.words
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
