{ ... }: {
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
  wayland.windowManager.hyprland.extraConfig = ''
    windowrulev2 = float,class:(com.nextcloud.desktopclient.nextcloud)
    windowrulev2 = size 25% 75%,class:(com.nextcloud.desktopclient.nextcloud)
    windowrulev2 = move 74% 4%,class:(com.nextcloud.desktopclient.nextcloud)
    '';
}
