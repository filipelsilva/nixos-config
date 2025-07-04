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

  # https://www.contraption.co/postcard-open-source/
  # https://github.com/RazgrizHsu/immich-mediakit
  # https://github.com/Stirling-Tools/Stirling-PDF
  # https://send.djazz.se/
  # https://github.com/calibrain/calibre-web-automated-book-downloader
}
