{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    screen
    tmuxp # automatically create tmux session with layouts
  ];

  programs = {
    tmux.enable = true;
    tmate.enable = true;
  };
}
