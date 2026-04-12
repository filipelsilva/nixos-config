{ ... }:
let
  passwordFile = builtins.toFile "upspasswordfile" "passebuefixe";
in
{
  flake.modules.nixos.services_ups =
    { ... }:
    {
      power.ups = {
        enable = true;
        mode = "standalone";
        ups.salicru = {
          driver = "nutdrv_qx";
          description = "Salicru SPS ONE 700VA";
          port = "auto";
        };
        upsd = {
          listen = [
            {
              address = "127.0.0.1";
              port = 3493;
            }
          ];
        };
        users.ups = {
          passwordFile = passwordFile;
          instcmds = [ "ALL" ];
          actions = [ "SET" ];
        };
        upsmon = {
          monitor.salicru = {
            user = "ups";
            type = "master";
            system = "salicru@127.0.0.1:3493";
            passwordFile = passwordFile;
          };
        };
      };
    };
}
