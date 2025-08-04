# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, user, ... }:
{
  imports = [
    ../../nixos
    ../../nixos/docker.nix
    ../../nixos/desktop
    ../../nixos/desktop/ddcci-driver.nix
    ../../nixos/desktop/android.nix
    ../../nixos/desktop/bluetooth.nix
    ./hardware.nix
  ];

  home-manager.users.${user}.imports = [
    ./home.nix
  ];

  networking.hostName = "inspiron";

  boot = {
    initrd.kernelModules = [ "xe" ];
    kernelParams = [ "xe.force_probe=9a49" ];
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        (vaapiIntel.override { enableHybridCodec = true; })
        vaapiVdpau
        libvdpau-va-gl
        intel-compute-runtime
        vpl-gpu-rt
      ];
    };
  };
}
