{
  config,
  pkgs,
  lib,
  headless,
  ...
}:
let
  nixosConfig = config;
in
{
  systemd.user.services.darkman = {
    enable = true;
    description = "darkman";
    wantedBy = [ "default.target" ];
    path = with pkgs; [
      glib
      gsettings-desktop-schemas
    ];
    environment = {
      XDG_DATA_DIRS = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:\${XDG_DATA_DIRS}";
    };
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.darkman}/bin/darkman run ";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  homeConfig =
    { config, ... }:
    {
      home.packages = with pkgs; [
        darkman
      ];

      home.file = {
        ".config/darkman/config.yaml".text = ''
          lat: ${lib.strings.floatToString nixosConfig.location.latitude}
          lng: ${lib.strings.floatToString nixosConfig.location.longitude}
          usegeoclue: false
          dbusserver: true
          portal: false
        '';

        ".local/share/dark-mode.d/headless.sh" = {
          executable = true;
          text = ''
            #!${pkgs.dash}/bin/dash

            # Change Vim/Neovim background
            ${pkgs.coreutils}/bin/rm -f /tmp/lightmode

            for server in $(${pkgs.neovim-remote}/bin/nvr --serverlist); do
              ${pkgs.coreutils}/bin/timeout 10s ${pkgs.neovim-remote}/bin/nvr --servername "$server" -cc 'set background=dark'
            done
          '';
        };

        ".local/share/light-mode.d/headless.sh" = {
          executable = true;
          text = ''
            #!${pkgs.dash}/bin/dash

            # Change Vim/Neovim background
            ${pkgs.coreutils}/bin/touch /tmp/lightmode

            for server in $(${pkgs.neovim-remote}/bin/nvr --serverlist); do
              ${pkgs.coreutils}/bin/timeout 10s ${pkgs.neovim-remote}/bin/nvr --servername "$server" -cc 'set background=light'
            done
          '';
        };

        ".local/share/dark-mode.d/graphical.sh" = {
          enable = !headless;
          executable = true;
          text = ''
            #!${pkgs.dash}/bin/dash

            # Change Alacritty theme
            ${pkgs.coreutils}/bin/cp $HOME/.config/alacritty/dark.toml $HOME/.config/alacritty/alacritty.toml

            # Change system theme (only if D-Bus session is available)
            if [ -S "''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/bus" ]; then
              export DBUS_SESSION_BUS_ADDRESS="unix:path=''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/bus"
              ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
              ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
            fi
          '';
        };

        ".local/share/light-mode.d/graphical.sh" = {
          enable = !headless;
          executable = true;
          text = ''
            #!${pkgs.dash}/bin/dash

            # Change Alacritty theme
            ${pkgs.coreutils}/bin/cp $HOME/.config/alacritty/light.toml $HOME/.config/alacritty/alacritty.toml

            # Change system theme (only if D-Bus session is available)
            if [ -S "''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/bus" ]; then
              export DBUS_SESSION_BUS_ADDRESS="unix:path=''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/bus"
              ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
              ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"
            fi
          '';
        };
      };
    };
}
