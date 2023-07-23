{
  config,
  pkgs,
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
in {
  home.file = {
    ".xinitrc".text = ''exec i3'';
    ".background-image".source = blissNew;
    ".config/alacritty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/alacritty/.config/alacritty";
    ".config/i3".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/i3/.config/i3";
    ".config/i3status".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/i3/.config/i3status";
    ".config/sxiv".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/sxiv/.config/sxiv";
    ".Xresources".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/xresources/.Xresources";
    ".config/zathura/zathurarc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/zathura/.config/zathura/zathurarc";

    ".config/redshift/hooks/brightness.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env sh

        exec >> $HOME/.redshift-hooks.log 2>&1

        if [ "$1" = period-changed ]; then
          echo $(date +"%y-%m-%d %H:%M:%S") $@
          ${pkgs.darkman}/bin/darkman run
        fi
      '';
    };

    ".config/darkman/config.yaml".text = ''
      usegeoclue: true
      dbusserver: true
      portal: true
    '';

    ".local/share/dark-mode.d/dark-mode.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env sh

        # Change system theme
        #sed -i 's/gtk-theme-name=.*/gtk-theme-name="Arc-Dark"/g' $HOME/.gtkrc-2.0
        #sed -i 's/gtk-theme-name=.*/gtk-theme-name=Arc-Dark/g' $HOME/.config/gtk-3.0/settings.ini

        # Change Alacritty theme
        sed -i 's/colors: .*/colors: *gruvbox-dark/g' $HOME/.config/alacritty/alacritty.yml

        # Change Neovim background
        for server in $(${pkgs.neovim-remote}/bin/nvr --serverlist); do
          ${pkgs.neovim-remote}/bin/nvr --servername "$server" -cc 'set background=dark'
        done
        sed -i 's/set background=.*/set background=dark/g' $HOME/.vim/vimrc
      '';
    };

    ".local/share/light-mode.d/light-mode.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env sh

        # Change system theme
        #sed -i 's/gtk-theme-name=.*/gtk-theme-name="Arc-Lighter"/g' $HOME/.gtkrc-2.0
        #sed -i 's/gtk-theme-name=.*/gtk-theme-name=Arc-Lighter/g' $HOME/.config/gtk-3.0/settings.ini

        # Change Alacritty theme
        sed -i 's/colors: .*/colors: *gruvbox-light/g' $HOME/.config/alacritty/alacritty.yml

        # Change Neovim background
        for server in $(${pkgs.neovim-remote}/bin/nvr --serverlist); do
          ${pkgs.neovim-remote}/bin/nvr --servername "$server" -cc 'set background=light'
        done
        sed -i 's/set background=.*/set background=light/g' $HOME/.vim/vimrc
      '';
    };
  };
}
