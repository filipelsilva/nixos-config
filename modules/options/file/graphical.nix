{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    rapid-photo-downloader
  ];

  xdg = {
    mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura.desktop";
        "image/jpeg" = "sxiv.desktop";
        "image/jpg" = "sxiv.desktop";
        "image/png" = "sxiv.desktop";
        "inode/directory" = "thunar.desktop";
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
