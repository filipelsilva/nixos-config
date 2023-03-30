{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    discord
  ];

  nixpkgs.overlays = let
    discordOverlay = self: super: {
      discord = super.discord.override {
        withOpenASAR = true;
      };
    };
  in [discordOverlay];
}
