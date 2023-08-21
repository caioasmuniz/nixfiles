{ pkgs, ... }: {
  imports = [
    ./zsh.nix
    ./xdg.nix
    ./gtk.nix
    ./wofi.nix
    ./kitty.nix
    ./waybar.nix
    ./swaync.nix
    ./firefox.nix
    ./darkman.nix
    ./swayosd.nix
    ./hyprland.nix
    ./swayidle.nix
    ./polkit-agent.nix
    ./android-studio.nix
    ./nextcloud-client.nix
  ];

  home = {
    username = "caio";
    homeDirectory = "/home/caio";
    stateVersion = "22.11";
    packages = with pkgs; [
      gnome.nautilus
      gnome.geary
      qalculate-gtk
      wdisplays
      libnotify
      brightnessctl
      pavucontrol
      wl-clipboard
      osu-lazer-bin
      libsecret
      mpv
      imv
      lutris
      networkmanagerapplet
      libreoffice-fresh
      deluge
      bottles
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
      components = [ "pkcs11" "secrets" "ssh" ];
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

