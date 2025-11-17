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
    ../../nixos/ollama.nix
    ../../nixos/desktop
    ./hardware.nix
  ];

  home-manager.users.${user}.imports = [
    ./home.nix
  ];

  programs.shade.hyprland.settings = {
    monitor = [
      "eDP-1,1920x1080@60,0x0,1"
    ];

    env = [
      "AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0"
      #"LIBVA_DRIVER_NAME,nvidia"
      "XDG_SESSION_TYPE,wayland"
      "GBM_BACKEND,nvidia-drm"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "NVD_BACKEND,direct"
      #"DRI_PRIME,1"
    ];
  };

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

  users.users.caio.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHgNS5i0tJexqz53w7NFhme6ix8KeYMsgwiZuZeldMWD daviaaze@gmail.com"
  ];

  services = {
    tailscale.enable = true;
    greetd.settings.initial_session = {
      command = "${lib.getExe pkgs.uwsm} start hyprland-uwsm.desktop";
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
    pkgs.nvtopPackages.nvidia
    pkgs.egl-wayland
    pkgs.immich-machine-learning
  ];
  networking.firewall.allowedTCPPorts = [ 3003 ];
}
