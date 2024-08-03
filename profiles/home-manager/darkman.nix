{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user} = {
    home.packages = with pkgs; [darkman];

    systemd.user = {
      enable = true;
      startServices = "legacy";
      services.darkman = {
        Unit = {
          Description = "Darkman Service";
        };
        Install = {
          WantedBy = ["default.target"];
        };
        Service = {
          ExecStart = pkgs.writeShellScript "darkman-service" ''
            #!${pkgs.dash}/bin/dash
            ${pkgs.coreutils}/bin/touch /tmp/lightmode
            ${pkgs.darkman}/bin/darkman run
          '';
        };
      };
    };
  };
}
