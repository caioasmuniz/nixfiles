{ pkgs, ... }:
{
  programs = {
    dconf.enable = true;
    seahorse.enable = true;
    geary.enable = true;
  };
  services.gnome = {
    gnome-online-accounts.enable = true;
    gnome-keyring.enable = true;
    at-spi2-core.enable = true;
  };
  xdg.portal.extraPortals = with pkgs; [
    gnome-keyring
    xdg-desktop-portal-gtk
  ];
}
