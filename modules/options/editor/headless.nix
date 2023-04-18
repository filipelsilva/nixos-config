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
    neovim
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

  services.rsyncd.enable = true;
}
