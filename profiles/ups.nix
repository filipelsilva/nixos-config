{...}: let
  passwordFile = builtins.toFile "upspasswordfile" "passebuefixe";
in {
  power.ups = {
    enable = true;
    mode = "standalone";
    ups.salicru = {
      # find your driver here: https://networkupstools.org/docs/man/usbhid-ups.html
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
      instcmds = ["ALL"];
      actions = ["SET"];
    };
    upsmon = {
      # settings = {};
      monitor.salicru = {
        user = "ups";
        type = "master";
        system = "salicru@127.0.0.1:3493";
        passwordFile = passwordFile;
      };
    };
  };
}
