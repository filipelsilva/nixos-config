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
}
