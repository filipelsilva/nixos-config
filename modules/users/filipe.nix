{pkgs, ...}: {
  users = {
    groups.filipe = {
      name = "filipe";
      members = ["filipe"];
    };
    users.filipe = {
      isNormalUser = true;
      initialPassword = "password";
      shell = pkgs.zsh;
      description = "Filipe Ligeiro Silva";
      group = "filipe";
      extraGroups = [
        "audio"
        "docker"
        "dialout"
        "libvirtd"
        "networkmanager"
        "storage"
        "vboxusers"
        "video"
        "wheel"
      ];
    };
  };
}
