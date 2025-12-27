{
  pkgs,
  dataPool,
  ...
}: {
  services.copyparty = {
    enable = true;
    user = "copyparty";
    group = "copyparty";
    settings = {
      rp-loc = "/files";
    };
    volumes = {
      "/" = {
        path = dataPool.location;
        access = {
          r = "*";
          rw = "*";
        };
      };
    };
  };

  users.users.copyparty.extraGroups = ["media"];

  environment.systemPackages = with pkgs; [
    copyparty
  ];
}
