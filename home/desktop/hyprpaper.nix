{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [
        "${builtins.path { path = ../../assets/bigsur-day.jpg; }}"
        "${builtins.path { path = ../../assets/bigsur-night.jpg; }}"
      ];
      wallpaper = [ ",${builtins.path { path = ../../assets/bigsur-day.jpg; }}" ];
    };
  };
}
