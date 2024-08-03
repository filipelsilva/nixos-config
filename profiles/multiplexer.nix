{pkgs, ...}: {
  programs.tmux.enable = true;

  environment.systemPackages = with pkgs; [
    screen
  ];
}
