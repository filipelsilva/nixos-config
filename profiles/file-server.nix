{pkgs, ...}: {
  environment.systemPackages = with pkgs; [dufs];

  systemd.services.file-server = {
    description = "file server using dufs";
    wantedBy = ["default.target"];
    script = ''
      ${pkgs.dufs}/bin/dufs -A
    '';
  };
}
