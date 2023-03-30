{
  config,
  inputs,
  ...
}: {
  system = {
    stateVersion = "22.11";
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };
}
