{ ... }:
{
  flake.modules.nixos.programs_file-graphical =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        nautilus
        file-roller
      ];

      programs.nautilus-open-any-terminal = {
        enable = true;
        terminal = "alacritty";
      };

      services = {
        gvfs.enable = true; # Enables things like trashing files
        tumbler.enable = true;
        croc.enable = true;
      };

      xdg = {
        mime = {
          enable = true;
          defaultApplications = {
            "application/pdf" = "org.pwmt.zathura.desktop";
            "inode/directory" = "nautilus.desktop";
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
    };
}
