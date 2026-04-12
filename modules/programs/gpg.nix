{ ... }:
{
  flake.modules.nixos.programs_gpg =
    { ... }:
    {
      programs.gnupg = {
        agent = {
          enableExtraSocket = true;
          enableBrowserSocket = true;
          enableSSHSupport = false;
          enable = true;
        };
      };
    };
}
