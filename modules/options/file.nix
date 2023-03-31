{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    file-roller.enable = true; # Archive manager for thunar
  };

  services = {
    gvfs.enable = true; # Enables things like trashing files in Thunar
    tumbler.enable = true;
    croc.enable = true;
  };

  boot.supportedFilesystems = ["ntfs"];

  xdg.mime.defaultApplications = {
    "application/pdf" = "zathura.desktop";
    "image/jpeg" = "sxiv.desktop";
  };

  environment.systemPackages = with pkgs; [
    magic-wormhole
    progress
  ];
}
