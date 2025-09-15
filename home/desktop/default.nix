{ pkgs, ... }:
{
  imports = [
    ./darkman.nix
    ./gtk.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    # ./hyprpaper.nix
    ./polkit-agent.nix
    ./stash.nix
    ./xdg.nix
    ./timewall.nix
    # ./nextcloud-client.nix
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
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    gnome-keyring = {
      enable = true;
      components = [
        "pkcs11"
        "secrets"
        "ssh"
      ];
    };
    wlsunset = {
      enable = true;
      latitude = "-23.1";
      longitude = "-50.6";
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
