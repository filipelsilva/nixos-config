{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    screen
  ];

  programs.tmux.enable = true;
}
