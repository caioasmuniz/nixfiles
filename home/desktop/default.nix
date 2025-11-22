{ pkgs, ... }:
{
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
  ];
  home.packages = with pkgs; [
    qalculate-gtk
    wl-clipboard
    satty
    mpv
    loupe
    fragments
    spotify
    discord
    moonlight-qt
    resources
    trayscale
  ];
  services = {
    udiskie.enable = true;
    polkit-gnome.enable = true;
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    wlsunset = {
      enable = true;
      latitude = "-23.1";
      longitude = "-50.6";
    };
  };
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/wm/preferences".button-layout = ":";
    };
  };

  programs = {
    obs-studio.enable = true;
    chromium.enable = true;
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "caioasmuniz";
      userEmail = "caiomuniz888@gmail.com";
    };
  };
}
