{ pkgs, ... }:
{
  flake.modules.nixos.virtualisation_vagrant =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ vagrant ];

      services.nfs.server.enable = true;

      networking.firewall.extraCommands = ''
        ip46tables -I INPUT 1 -i vboxnet+ -p tcp -m tcp --dport 2049 -j ACCEPT
      '';

      networking.firewall.interfaces."virbr1" = {
        allowedTCPPorts = [ 2049 ];
        allowedUDPPorts = [ 2049 ];
      };
    };
}
