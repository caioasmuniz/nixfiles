# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  lib,
  user,
  ...
}:
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
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        (intel-vaapi-driver.override { enableHybridCodec = true; })
        libva-vdpau-driver
        libvdpau-va-gl
        intel-compute-runtime
        vpl-gpu-rt
      ];
    };
  };

  services.greetd.settings.initial_session = {
    command = "${lib.getExe pkgs.uwsm} start hyprland-uwsm.desktop";
    user = user;
  };

  programs.shade.hyprland.settings = {
    monitor = [
      "eDP-1,1920x1080@60,auto,1.25"
      "desc:LG Electronics LG HDR WFHD 0x0003187E,2560x1080@75,auto-left,1"
    ];

    workspace = [
      "1, monitor:eDP-1, default:true"
      "10, monitor:DP-1, default:true"
      "10, monitor:HDMI-A-1, default:true"
    ];

    bind = [
      "SUPER,C,exec, uwsm-app -t service -- code.desktop ~/Documents/nixfiles/nixfiles.code-workspace"
    ];

    exec = [ "hyprlock" ];
  };
}
