{ ... }: {
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
  wayland.windowManager.hyprland.extraConfig = ''
    windowrulev2 = float,class:(com.nextcloud.desktopclient.nextcloud)
    windowrulev2 = size 400 800,class:(com.nextcloud.desktopclient.nextcloud)
    windowrulev2 = move 100%-412 44,class:(com.nextcloud.desktopclient.nextcloud)
    '';
}
