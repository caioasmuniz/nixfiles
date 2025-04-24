{ pkgs, ... }: {
  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = false;
  };
  environment.systemPackages = [ pkgs.overskride ];
}
