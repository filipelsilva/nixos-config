{
  config,
  pkgs,
  lib,
  headless,
  ...
}: let
  nixosConfig = config;
in {
  homeConfig = {config, ...}: {
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

          # Change system theme
          ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
          ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
        '';
      };

      ".local/share/light-mode.d/graphical.sh" = {
        enable = !headless;
        executable = true;
        text = ''
          #!${pkgs.dash}/bin/dash

          # Change Alacritty theme
          ${pkgs.coreutils}/bin/cp $HOME/.config/alacritty/light.toml $HOME/.config/alacritty/alacritty.toml

          # Change system theme
          ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
          ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"
        '';
      };
    };
  };
}
