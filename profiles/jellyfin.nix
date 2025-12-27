{pkgs, ...}: {
  services.jellyfin = {
    enable = true;
    user = "jellyfin";
    group = "jellyfin";
  };

  users.users.jellyfin.extraGroups = ["media"];
  userConfig.extraGroups = ["media"];

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
}
