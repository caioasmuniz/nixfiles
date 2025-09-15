{ ... }:
{
  imports = [
    ../../home
  ];

  wayland.windowManager.hyprland = {
    extraConfig = ''
      device {
        name=DLL09D9:00 04F3:3146 Touchpad
        accel_profile=adaptive
      }'';

    settings = {
      monitor = [
        "eDP-1,1920x1080@60,auto,1.25"
        "desc:LG Electronics LG HDR WFHD 0x0003187E,2560x1080@75,auto-left,1"
      ];
      
      workspace = [
        "1, monitor:eDP-1, default:true"
        "10, monitor:DP-1, default:true"
        "10, monitor:HDMI-A-1, default:true"
      ];
    };
  };

}
