{ pkgs, ... }:
{
  imports = [
    ./ags
    ./fish.nix
    ./ssh.nix
    ./xdg.nix
    ./gtk.nix
    ./ghostty.nix
    ./gaming.nix
    ./firefox.nix
    ./darkman.nix
    ./hyprland.nix
    ./hyprlock.nix
    #./hypridle.nix
    ./hyprpaper.nix
    ./polkit-agent.nix
    ./nextcloud-client.nix
  ];
  home = {
    username = "caio";
    homeDirectory = "/home/caio";
    stateVersion = "22.11";
    packages = with pkgs; [
      qalculate-gtk
      wl-clipboard
      libsecret
      satty
      mpv
      loupe
      wpaperd
      fragments
      stremio
      spotify
      discord
      moonlight-qt
      resources
      trayscale
    ];
  };
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
    vscode.enable = true;
    chromium.enable = true;
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "caioasmuniz";
      userEmail = "caiomuniz888@gmail.com";
    };
  };
}
