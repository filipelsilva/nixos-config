{
  pkgs,
  user,
  ...
}: let
  bliss = pkgs.fetchurl {
    url = "https://archive.org/download/bliss-600dpi/bliss-600dpi.png";
    sha256 = "a72d44ee40c406a1b8837a94e7fc8834bd7f6f22e8c5da9aa28da9d5922d47da";
  };
  blissNew = pkgs.fetchurl {
    url = "https://msdesign.blob.core.windows.net/wallpapers/Microsoft_Nostalgic_Windows_Wallpaper_4k.jpg";
    sha256 = "8f9a38bfc0f5670eb8d92e92539719c1086abee4313930f4ad1fd1e7ad6d305e";
  };
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
  home-manager.users.${user} = {config, ...}: {
    home.file = {
    ".xinitrc".text = ''exec i3'';
    ".background-image".source = blissNew;
    ".config/alacritty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/alacritty/.config/alacritty";
    ".config/i3".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/i3/.config/i3";
    ".config/i3status".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/i3/.config/i3status";
    ".config/dunst".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/dunst/.config/dunst";
    ".config/sxiv".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/sxiv/.config/sxiv";
    ".Xresources".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/xresources/.Xresources";
    ".config/zathura/zathurarc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/zathura/.config/zathura/zathurarc";

    ".local/share/dark-mode.d/graphical.sh" = {
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
  };
}
