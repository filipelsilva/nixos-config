{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    ed
    gnused
    sd
    vimHugeX
    bvi
    bless # Hex editor

    # Pagers
    less
    lesspipe
    bat
    hexyl

    # Finders
    fzf
    fd
    silver-searcher
    pdfgrep
    ripgrep
    ripgrep-all
    plocate

    # Run commands when files change
    entr
    watchexec
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  services.rsyncd.enable = true;
}
