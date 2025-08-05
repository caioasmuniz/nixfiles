{ inputs, lib, ... }:
{
  imports = [
    inputs.vscode-server.homeModules.default
    ../../home
  ];

  services = {
    hypridle.enable = lib.mkForce false;
    vscode-server.enable = true;
  };

  wayland.windowManager.hyprland.settings = {
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
}
