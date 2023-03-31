{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    screen
    tmuxp # automatically create tmux session with layouts
    mprocs
  ];

  programs.tmux.enable = true;
  services.tmate-ssh-server.enable = true;
}
