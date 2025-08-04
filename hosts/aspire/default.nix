{
  config,
  pkgs,
  lib,
  user,
  ...
}:
{
  imports = [
    ../../nixos
    ../../nixos/desktop
    ./hardware.nix
  ];

  home-manager.users.${user}.imports = [
    ./home.nix
  ];

  networking = {
    hostName = "aspire";
    interfaces.enp3s0.wakeOnLan.enable = true;
  };
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        intel-media-driver
        (vaapiIntel.override { enableHybridCodec = true; })
        vaapiVdpau
        libvdpau-va-gl
        intel-compute-runtime
        intel-media-sdk
      ];
    };
    nvidia = {
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
  };
  services = {
    greetd.settings.initial_session = {
      command = lib.getExe config.programs.hyprland.package;
      user = user;
    };
    sunshine = {
      enable = true;
      #package = pkgs.sunshine.override { cudaSupport = true; };
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
    xserver.videoDrivers = [ "nvidia" ];
  };
  environment.systemPackages = [
    pkgs.nvtop
    pkgs.egl-wayland
  ];
}
