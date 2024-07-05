{pkgs, ...}: let
  passwordFile = pkgs.writeText "ups-user-password" "upsupsups";
in {
  # at some point something will make a /var/state/ups directory,
  # chown that to nut:
  # $ sudo chown nut:nut /var/state/ups
  power.ups = {
    enable = true;
    mode = "standalone";
    schedulerRules = "/etc/nixos/.config/nut/upssched.conf";
    # debug by calling the driver:
    # $ sudo NUT_CONFPATH=/etc/nut/ usbhid-ups -u nut -D -a salicru
    ups.salicru = {
      # find your driver here:
      # https://networkupstools.org/docs/man/usbhid-ups.html
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
      passwordFile = "/home/filipe/bro";
      instcmds = ["ALL"];
      actions = ["SET"];
    };
    upsmon = {
      # settings = {};
      monitor.salicru = {
        user = "ups";
        type = "master";
        system = "salicru@127.0.0.1:3493";
        passwordFile = "/home/filipe/bro";
      };
    };
  };

  #   users = {
  #     users.nut = {
  #       isSystemUser = true;
  #       group = "nut";
  #       # it does not seem to do anything with this directory
  #       # but something errored without it, so whatever
  #       home = "/var/lib/nut";
  #       createHome = true;
  #     };
  #     groups.nut = {};
  #   };
}
