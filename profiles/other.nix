{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bc # Calculator
    calibre # E-book software
  ];
}
