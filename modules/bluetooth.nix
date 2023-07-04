{ ... }: {
  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = false;
  };
  services.blueman.enable = true;
}
