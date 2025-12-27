{pkgs, ...}: {
  services.copyparty = {
    enable = true;
    user = "copyparty";
    group = "copyparty";
  };

  users.users.copyparty.extraGroups = ["media"];

  environment.systemPackages = with pkgs; [
    copyparty
  ];
}
