{
  config,
  lib,
  ...
}: {
  userConfig.extraGroups = ["docker"];

  virtualisation = {
    docker = {
      enable = true;
      rootless.enable = true;
    };
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  hardware.nvidia-container-toolkit.enable = lib.mkIf (builtins.any (x: x == "nvidia") config.services.xserver.videoDrivers) true;

  # virtualisation.oci-containers.containers = {
  #   hackagecompare = {
  #     image = "chrissound/hackagecomparestats-webserver:latest";
  #     ports = ["127.0.0.1:3010:3010"];
  #     volumes = [
  #       "/root/hackagecompare/packageStatistics.json:/root/hackagecompare/packageStatistics.json"
  #     ];
  #     cmd = [
  #       "--base-url"
  #       "\"/hackagecompare\""
  #     ];
  #   };
  # };

  # https://www.reddit.com/r/immich/comments/1le3nco/immich_mediakit_a_smarter_way_to_manage_your/
  # https://send.djazz.se/
  # https://github.com/calibrain/calibre-web-automated-book-downloader
}
