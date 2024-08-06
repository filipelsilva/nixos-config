{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pandoc
    zathura
    diffpdf
  ];

  homeConfig = {config, ...}: {
    home.file = {
      ".config/zathura/zathurarc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/zathura/.config/zathura/zathurarc";
    };
  };
}
