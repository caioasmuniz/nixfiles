{ ... }: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || hyprlock";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "hyprlock";
          on-resume = "notify-send 'Welcome back!'";
        }
        {
          timeout = 380;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800; # 30min
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
