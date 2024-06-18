{pkgs, ...}: {
  environment.systemPackages = with pkgs; [darkman];

  powerManagement.powerUpCommands = ''
    ${pkgs.darkman}/bin/darkman run >> $HOME/.darkman.log 2>&1 &
  '';
}
