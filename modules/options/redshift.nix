{
  config,
  inputs,
  ...
}: {
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
