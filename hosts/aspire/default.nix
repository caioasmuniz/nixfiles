# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, ... }: {
  imports = [ ../../modules ./hardware.nix ];
  networking.hostName = "aspire";
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    open = false;
    modesetting.enable = true;
    powerManagement.enable = false;
    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:0:1:0";
      intelBusId = "PCI:0:0:2";
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];
}
