{ pkgs, ... }: {
  home.packages = [ pkgs.darkman ];
  systemd.user.services.darkman = {
    Unit = {
      Description = "Framework for dark-mode and light-mode transitions.";
      Documentation = "man:darkman(1)";
    };
    Service = {
      Type = "dbus";
      ExecStart = "${pkgs.darkman}/bin/darkman run";
      Restart = "on-failure";
      Environment = "PATH=/run/current-system/sw/bin";
      TimeoutStopSec = 15;
      Slice = "background.slice";
      BusName = "nl.whynothugo.darkman";
      RestrictNamespaces = "yes";
      SystemCallArchitectures = "native";
      SystemCallFilter = "@system-service @timer";
      MemoryDenyWriteExecute = "yes";
    };
    Install.WantedBy = [ "hyprland-session.target" ];
  };

  xdg.configFile."darkman/config.yaml".text = ''
    lat: -23.1
    lng: -50.6
    dbusserver: true
    usegeoclue: false
    portal: true
  '';
  xdg.dataFile."light-mode.d/light.sh" = {
    executable = true;
    text = ''
      ${pkgs.swaybg}/bin/swaybg -m fill -i ~/Pictures/bigsur-day.jpg &

      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/gtk-theme '"Adwaita-dark"'
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme '"prefer-light"'

      ln -sf ~/.config/kitty/themes/adwaita.conf ~/.config/kitty/current-theme.conf
      pkill -USR1 kitty

      ${pkgs.libnotify}/bin/notify-send --app-name="darkman" --urgency=low --icon=weather-clear-symbolic "switching to light mode"
    '';
  };
  xdg.dataFile."dark-mode.d/dark.sh" = {
    executable = true;
    text = ''
      ${pkgs.swaybg}/bin/swaybg -m fill -i ~/Pictures/bigsur-night.jpg &

      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/gtk-theme '"Adwaita"'
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme '"prefer-dark"'

      ln -sf ~/.config/kitty/themes/adwaita-dark.conf ~/.config/kitty/current-theme.conf
      pkill -USR1 kitty

      ${pkgs.libnotify}/bin/notify-send --app-name="darkman" --urgency=low --icon=weather-clear-symbolic-night "switching to dark mode"
    '';
  };
}
