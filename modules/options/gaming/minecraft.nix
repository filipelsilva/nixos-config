{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    minecraft
    optifine
  ];
}
