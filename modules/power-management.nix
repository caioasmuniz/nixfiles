{ ... }: {

  powerManagement = {
    cpuFreqGovernor = "ondemand";
    enable = true;
    powertop.enable = true;
  };
  services = {
    power-profiles-daemon.enable = true;
    thermald.enable = true;
  };
}
