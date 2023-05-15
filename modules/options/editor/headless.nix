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
    vim
    neovim

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

    # Run commands when files change
    entr
    watchexec

    # Convert files to UNIX format
    dos2unix
  ];

  services = {
    rsyncd.enable = true;
    locate = {
      enable = true;
      locate = pkgs.plocate;
      localuser = null;
    };
  };
}
