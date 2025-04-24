{ pkgs, ... }:
{
  programs.hyprland.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    SDL_VIDEODRIVER = "wayland";
  };
}
