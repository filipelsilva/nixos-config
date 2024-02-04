{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
  ];

  xdg = {
    mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "zathura.desktop";
        "image/jpeg" = "sxiv.desktop";
      };
    };
  };

  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        exo
        xfce4-settings
        thunar-volman
        thunar-archive-plugin
        thunar-media-tags-plugin
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
