{config, ...}: {
  users.users.filipe = {
    isNormalUser = true;
    initialPassword = "password";
    shell = pkgs.zsh;
    description = "Filipe Ligeiro Silva";
    extraGroups = [
      "audio"
      "docker"
      "libvirtd"
      "networkmanager"
      "storage"
      "vboxusers"
      "video"
      "wheel"
    ];
  };
}
