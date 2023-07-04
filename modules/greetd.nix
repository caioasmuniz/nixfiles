{ pkgs, ... }:
let
  swayConfig = pkgs.writeText "greetd-sway-config" ''
    exec "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP"
    exec "${pkgs.darkman}/bin/darkman run &"
    input "type:touchpad" {
      tap enabled
    }
    xwayland disable
    exec "${pkgs.greetd.regreet}/bin/regreet; swaymsg exit"
  '';
in
{
  security.pam.services.greetd.enableGnomeKeyring = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = "${pkgs.sway}/bin/sway --config ${swayConfig}";
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "caio";
      };
    };
  };

  environment.systemPackages = [ pkgs.gnome.adwaita-icon-theme ];

  programs.regreet = {
    enable = true;
    settings = {
      GTK = {
        cursor_theme_name = "Adwaita";
        font_name = "Fira Sans 12";
        icon_theme_name = "Adwaita";
      };
    };
  };
}
