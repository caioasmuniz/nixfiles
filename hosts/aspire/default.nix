{
  config,
  pkgs,
  lib,
  user,
  ...
}:
{
  imports = [
    ../../modules
    ../../modules/ollama.nix
    ../../modules/desktop
    ./hardware.nix
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
    pkgs.nvtopPackages.nvidia
    pkgs.egl-wayland
    pkgs.immich-machine-learning
  ];
  networking.firewall.allowedTCPPorts = [ 3003 ];
}
