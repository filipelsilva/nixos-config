{pkgs, ...}: {
  services.copyparty = {
    enable = true;
    user = "copyparty";
    group = "copyparty";
  };

  users.users.copyparty.extraGroups = ["media"];
  userConfig.extraGroups = ["media"];

  environment.systemPackages = with pkgs; [
    copyparty
  ];
}
