{
  config,
  pkgs,
  lib,
  headless,
  ...
}: let
  nixosConfig = config;

  xsettingsdCommon = ''
    Net/IconThemeName "Adwaita"
  '';
  xsettingsdFileDark = ''
    Net/ThemeName "Adwaita-dark"
    ${xsettingsdCommon}
  '';
  xsettingsdFileLight = ''
    Net/ThemeName "Adwaita"
    ${xsettingsdCommon}
  '';
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
          for server in $(${pkgs.neovim-remote}/bin/nvr --serverlist); do
            ${pkgs.neovim-remote}/bin/nvr --servername "$server" -cc 'set background=dark'
          done
          ${pkgs.coreutils}/bin/rm -f /tmp/lightmode
        '';
      };

      ".local/share/light-mode.d/headless.sh" = {
        executable = true;
        text = ''
          #!${pkgs.dash}/bin/dash

          # Change Vim/Neovim background
          for server in $(${pkgs.neovim-remote}/bin/nvr --serverlist); do
            ${pkgs.neovim-remote}/bin/nvr --servername "$server" -cc 'set background=light'
          done
          ${pkgs.coreutils}/bin/touch /tmp/lightmode
        '';
      };

      ".local/share/dark-mode.d/graphical.sh" = {
        enable = !headless;
        executable = true;
        text = ''
          #!${pkgs.dash}/bin/dash

          # Change system theme
          echo '${xsettingsdFileDark}' > $HOME/.xsettingsd
          ${pkgs.killall}/bin/killall -HUP xsettingsd

          ${pkgs.gnused}/bin/sed -i 's/color_scheme_path=\(.*\)airy.conf/color_scheme_path=\1darker.conf/g' $HOME/.config/qt5ct/qt5ct.conf

          # Change Alacritty theme
          ${pkgs.coreutils}/bin/cp $HOME/.config/alacritty/dark.toml $HOME/.config/alacritty/alacritty.toml
        '';
      };

      ".local/share/light-mode.d/graphical.sh" = {
        enable = !headless;
        executable = true;
        text = ''
          #!${pkgs.dash}/bin/dash

          # Change system theme
          echo '${xsettingsdFileLight}' > $HOME/.xsettingsd
          ${pkgs.killall}/bin/killall -HUP xsettingsd

          ${pkgs.gnused}/bin/sed -i 's/color_scheme_path=\(.*\)darker.conf/color_scheme_path=\1airy.conf/g' $HOME/.config/qt5ct/qt5ct.conf

          # Change Alacritty theme
          ${pkgs.coreutils}/bin/cp $HOME/.config/alacritty/light.toml $HOME/.config/alacritty/alacritty.toml
        '';
      };
    };

    systemd.user = {
      enable = true;
      startServices = "legacy";
      services.darkman = {
        Unit = {
          Description = "Darkman Service";
        };
        Install = {
          WantedBy = ["default.target"];
        };
        Service = {
          ExecStart = pkgs.writeShellScript "darkman-service" ''
            #!${pkgs.dash}/bin/dash
            ${pkgs.coreutils}/bin/touch /tmp/lightmode
            ${pkgs.darkman}/bin/darkman run
          '';
        };
      };
    };
  };
}
