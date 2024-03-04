{ ... }: {
  services.hypridle = {
    enable = true;
    listeners = [
      {
        timeout = 300;
        onTimeout = "hyprlock";
        onResume = "notify-send 'Welcome back!'";
      }
      {
        timeout = 380;
        onTimeout = "hyprctl dispatch dpms off";
        onResume = "hyprctl dispatch dpms on";
      }
      {
        timeout = 1800; # 30min
        onTimeout = "systemctl suspend";
      }
    ];
  };
}
