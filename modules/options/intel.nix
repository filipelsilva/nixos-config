{...}: {
  services.xserver.videoDrivers = ["intel"];
  # services.xserver.deviceSection = ''
  #   Option "DRI" "2"
  #   Option "TearFree" "true"
  # '';
}
