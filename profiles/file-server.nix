{pkgs, ...}: {
  services.copyparty = {
    enable = true;
    user = "copyparty";
    group = "copyparty";
    settings = {
      rp-loc = "/files";
    };
  };

  users.users.copyparty.extraGroups = ["media"];

  environment.systemPackages = with pkgs; [
    copyparty
  ];
}
