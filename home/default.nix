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
  ];

  home = {
    username = "caio";
    homeDirectory = "/home/caio";
    stateVersion = "22.11";
    packages = with pkgs; [
      gnome.dconf-editor
      gnome.adwaita-icon-theme
      gnome.nautilus
      gnome.geary
      qalculate-gtk
      gcr
      gsettings-desktop-schemas
      wdisplays
      libnotify
      brightnessctl
      pavucontrol
      obs-studio
      wl-clipboard
      libsForQt5.kdeconnect-kde
      osu-lazer-bin
      libsecret
      mpv
      imv
      lutris
      networkmanagerapplet
      gnome.gnome-control-center
      libreoffice-fresh
      chromium
      deluge
      bottles
    ];
  };
  services = {
    udiskie.enable = true;
    gnome-keyring = {
      enable = true;
      components = [ "pkcs11" "secrets" "ssh" ];
    };
  };
  programs = {
    vscode.enable = true;
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "caioasmuniz";
      userEmail = "caiomuniz888@gmail.com";
    };
  };
}

