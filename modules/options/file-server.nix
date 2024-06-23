{pkgs, ...}: {
  environment.systemPackages = with pkgs; [dufs];

  systemd.user.services.file-server = {
    description = "file server using dufs";
    wantedBy = ["default.target"];
    script = ''
      ${pkgs.dufs}/bin/dufs -A --log-file /var/log/file-server.log
    '';
  };
}
