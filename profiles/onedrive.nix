{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    onedrive
  ];
}
