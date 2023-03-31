{ inputs, pkgs, ... }: {

  imports = [
    ./zsh.nix
    ./xdg.nix
    ./wofi.nix
    ./waybar.nix
    ./swaync.nix
    ./firefox.nix
    ./hyprland.nix
    ./swayidle.nix
    ./polkit-agent.nix
  ];

  home = {
    username = "caio";
    homeDirectory = "/home/caio";
    stateVersion = "22.11";
    packages = with pkgs; [
      gnome.seahorse
      gnome.dconf-editor
      gnome.adwaita-icon-theme
      gnome.nautilus
      gnome.geary
      gcr
      gsettings-desktop-schemas
      qbittorrent
      wdisplays
      libnotify
      swaybg
      wlsunset
      brightnessctl
      playerctl
      pavucontrol
      obs-studio
      wl-clipboard
      libsForQt5.kdeconnect-kde
      fx_cast_bridge
      darkman
      wallutils
      kitty
      osu-lazer-bin
      bottles
      libsecret
      vulkan-tools
      mpv
      imv
      shotman
      lutris
      networkmanagerapplet
      gnome.gnome-control-center
      libreoffice-fresh
      inputs.fufexan.packages.${pkgs.hostPlatform.system
      }.spotify
    ];
  };

  services.gnome-keyring = {
    enable = true;
    components = [ "pkcs11" "secrets" "ssh" ];
  };
  programs = {
    vscode.enable = true;
    home-manager.enable = true;
  };
}

