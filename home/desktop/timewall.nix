{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.timewall.homeManagerModules.default
  ];
  home.packages = [ pkgs.swww ];
  wayland.windowManager.hyprland.extraConfig = "exec=swww-daemon";

  services.timewall = {
    enable = true;
    wallpaperPath = ../../assets/catalina.heic;
    config = {
      daemon = {
        update_interval_seconds = 600;
      };
      location = {
        lat = -23.1;
        lon = -50.6;
      };
      setter = {
        command = [
          "swww"
          "img"
          "%f"
        ];
        quiet = true;
        overlap = 0;
      };
    };
  };
}
