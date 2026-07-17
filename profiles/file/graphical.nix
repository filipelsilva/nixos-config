{
  pkgs,
  lib,
  system,
  ...
}:
let
  isLinux = lib.hasSuffix "linux" system;
in
{
  imports = lib.optional isLinux {
    programs.nautilus-open-any-terminal = {
      enable = true;
      terminal = "alacritty";
    };

    services = {
      gvfs.enable = true; # Enables things like trashing files
      tumbler.enable = true;
      croc.enable = true;
    };

    xdg.mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura.desktop";
        "inode/directory" = "nautilus.desktop";
      };
    };
  };

  nixpkgs.overlays = lib.optionals isLinux [
    (self: super: {
      gnome = super.gnome.overrideScope (
        gself: gsuper: {
          nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
            buildInputs =
              nsuper.buildInputs
              ++ (with pkgs.gst_all_1; [
                gst-plugins-good
                gst-plugins-bad
              ]);
          });
        }
      );
    })
  ];

  environment.systemPackages = with pkgs; lib.lists.optionals isLinux [
    nautilus
    file-roller
  ];

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
