{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      alacritty
    ];
    variables = {
      TERMINAL = "alacritty";
    };
  };
}
