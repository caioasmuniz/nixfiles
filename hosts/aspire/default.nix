{ config, pkgs, ... }: {
  imports = [ ../../modules ./hardware.nix ];
  networking = {
    hostName = "aspire";
    interfaces.enp3s0.wakeOnLan.enable = true;
  };
  hardware = {
    opengl = {
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

  services = {
    xserver.videoDrivers = [ "nvidia" ];
    sunshine = {
      enable = true;
      package = pkgs.sunshine.override { cudaSupport = true; };
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
  };
  environment.systemPackages = [ pkgs.nvtop pkgs.egl-wayland ];
}
