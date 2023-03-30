{
  config,
  inputs,
  ...
}: {
  location.provider = "geoclue2";

  services = {
    redshift = {
      enable = true;
      temperature = {
        day = 6500;
        night = 4500;
      };
    };
  };
}
