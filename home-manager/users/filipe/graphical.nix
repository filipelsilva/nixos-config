{
  config,
  pkgs,
  ...
}: {
  home.file = {
    ".xinitrc".text = ''exec i3'';
    ".background-image".source = pkgs.fetchurl {
      url = "https://images2.alphacoders.com/941/941898.jpg";
      sha256 = "31795d48aa6ee1b9d482bef954e44a86d8c6a5bd962cddb3736c3a3d530769ca";
    };

    ".config/alacritty/alacritty.yml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/alacritty/.config/alacritty/alacritty.yml";
    ".config/i3".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/i3/.config/i3";
    ".config/i3status".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/i3/.config/i3status";
    ".config/sxiv".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/sxiv/.config/sxiv";
    ".Xresources".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/xresources/.Xresources";
    ".config/zathura/zathurarc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/zathura/.config/zathura/zathurarc";
  };
}