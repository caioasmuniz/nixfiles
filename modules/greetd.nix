{ inputs, pkgs, ... }:
let
  swayConfig = pkgs.writeText "greetd-sway-config" ''
    exec "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP"
    input "type:touchpad" {
      tap enabled
    }
    xwayland disable
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
    exec "regreet; swaymsg exit"
  '';
in
{
  security.pam.services.greetd.enableGnomeKeyring = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = "${pkgs.sway}/bin/sway --config ${swayConfig}";
      initial_session = {
        command = "${inputs.hyprland.packages.${pkgs.hostPlatform.system}.default}/bin/Hyprland";
        user = "caio";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    gnome.adwaita-icon-theme
    greetd.regreet
    sway
  ];

  programs.regreet = {
    enable = true;
    package = pkgs.greetd.regreet;
    settings = {
      GTK = {
        cursor_theme_name = "Adwaita";
        font_name = "Fira Sans 12";
        icon_theme_name = "Adwaita";
        theme_name = "Adwaita-dark";
      };
    };
  };
}
