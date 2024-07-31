{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bc # Calculator
    ventoy-full # Make multiboot USB drives
    calibre # E-book software
  ];
}
