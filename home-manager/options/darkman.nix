{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [darkman];

  systemd.user = {
    enable = true;
    startServices = "legacy";
    services.darkman = {
      Unit = {
        Description = "Darkman Service";
      };
      Install = {
        After = ["default.target"];
        WantedBy = ["default.target"];
      };
      Service = {
        ExecStart = pkgs.writeShellScript "darkman-service" ''
          #!${pkgs.dash}/bin/dash
          touch /tmp/lightmode
          ${pkgs.darkman}/bin/darkman run >> ${config.home.homeDirectory}/.darkman.log
        '';
      };
    };
  };
}
