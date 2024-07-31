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
}
