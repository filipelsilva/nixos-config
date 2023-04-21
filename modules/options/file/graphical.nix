{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs.xfce; [
    exo
    xfce4-settings
  ];

  xdg.mime = {
    enable = true;
    addedAssociations = {
      "application/pdf" = "zathura.desktop";
      "image/jpeg" = "sxiv.desktop";
    };
  };

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
}
