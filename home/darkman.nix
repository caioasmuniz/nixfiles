{ pkgs, ... }: {
  services.darkman = {
    enable = true;
    settings = {
      lat = -23.1;
      lng = -50.6;
      dbusserver = true;
      usegeoclue = false;
      portal = true;
    };
    lightModeScripts.light = ''
      ${pkgs.swaybg}/bin/swaybg -m fill -i ~/Pictures/bigsur-day.jpg &
      
      rm ~/.config/gtklock/config.ini; echo -e "[main]\ngtk-theme=Adwaita" >>.config/gtklock/config.ini
      
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/gtk-theme '"Adwaita"'
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme '"prefer-light"'

      ln -sf ~/.config/kitty/themes/adwaita.conf ~/.config/kitty/current-theme.conf
      pkill -USR1 kitty

      ${pkgs.libnotify}/bin/notify-send --app-name="darkman" --urgency=low --icon=weather-clear-symbolic "switching to light mode"
    '';
    darkModeScripts.dark = ''
      ${pkgs.swaybg}/bin/swaybg -m fill -i ~/Pictures/bigsur-night.jpg &
      
      rm ~/.config/gtklock/config.ini; echo -e "[main]\ngtk-theme=Adwaita-dark" >>.config/gtklock/config.ini
      
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/gtk-theme '"Adwaita-dark"'
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme '"prefer-dark"'      

      ln -sf ~/.config/kitty/themes/adwaita-dark.conf ~/.config/kitty/current-theme.conf
      pkill -USR1 kitty
      
      ${pkgs.libnotify}/bin/notify-send --app-name="darkman" --urgency=low --icon=weather-clear-night-symbolic "switching to dark mode"
    '';
  };
}
