{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      alacritty
      gtkterm
    ];
    variables = {
      TERMINAL = "alacritty";
    };
  };

  userConfig.extraGroups = ["dialout"]; # For using serial connections

  homeConfig = {config, ...}: {
    home.file = {
      ".config/alacritty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/alacritty/.config/alacritty";
    };
  };
}
