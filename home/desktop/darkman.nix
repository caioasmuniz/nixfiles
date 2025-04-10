{ pkgs, ... }:
{
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
      hyprctl hyprpaper wallpaper ",${builtins.path { path = ../../assets/bigsur-day.jpg; }}" &

      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/gtk-theme '"Adwaita"'
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme '"prefer-light"'

      ln -sf ~/.config/kitty/themes/adwaita.conf ~/.config/kitty/current-theme.conf
      pkill -USR1 kitty

      ${pkgs.libnotify}/bin/notify-send --app-name="darkman" --urgency=low --icon=weather-clear-symbolic "switching to light mode"
    '';
    darkModeScripts.dark = ''
      hyprctl hyprpaper wallpaper ",${builtins.path { path = ../../assets/bigsur-night.jpg; }}" &

      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/gtk-theme '"Adwaita-dark"'
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme '"prefer-dark"'      

      ln -sf ~/.config/kitty/themes/adwaita-dark.conf ~/.config/kitty/current-theme.conf
      pkill -USR1 kitty

      ${pkgs.libnotify}/bin/notify-send --app-name="darkman" --urgency=low --icon=weather-clear-night-symbolic "switching to dark mode"
    '';
  };
}
