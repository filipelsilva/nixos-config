{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # rapid-photo-downloader # TODO: update this
    lxqt.lxqt-archiver
  ];

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
  };

  services = {
    gvfs.enable = true; # Enables things like trashing files in Thunar
    tumbler.enable = true;
    croc.enable = true;
  };

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

  homeConfig = {
    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        createDirectories = true;
      };
    };
  };
}
