{ ... }:
{
  flake.modules.nixos.desktop_bluetooth =
    { ... }:
    {
      services.blueman.enable = true;
      hardware = {
        bluetooth = {
          enable = true;
          powerOnBoot = true;
          settings = {
            General = {
              Enable = "Source,Sink,Media,Socket";
            };
          };
        };
      };
    };
}
