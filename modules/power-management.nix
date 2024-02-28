{ ... }: {
  powerManagement = {
    cpuFreqGovernor = "ondemand";
    enable = true;
    powertop.enable = false;
  };
  services = {
    power-profiles-daemon.enable = true;
    thermald.enable = true;
  };
}
