{
  config,
  inputs,
  ...
}: {
  location.provider = "geoclue2";

  services = {
    geoclue2 = {
      enable = true;
      appConfig.redshift.isAllowed = true;
    };
    redshift = {
      enable = true;
      temperature = {
        day = 6500;
        night = 4500;
      };
    };
  };
}
