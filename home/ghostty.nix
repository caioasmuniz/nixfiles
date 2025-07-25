{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.ghostty.packages.${pkgs.system}.default
  ];
  xdg.configFile."ghostty/config".text = ''
    font-family = CommitMono Nerd Font
    font-size = 10
    background-opacity = 0.75
    theme = light:Adwaita,dark:Adwaita Dark
    focus-follows-mouse = true
    gtk-tabs-location = bottom
    window-decoration = none
    minimum-contrast = 1.1
  '';
}
