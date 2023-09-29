{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    zoom-us
    discord
    slack
    skypeforlinux
  ];
}
