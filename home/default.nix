{ inputs, pkgs, ... }: {

  imports = [
    ./zsh.nix
    ./xdg.nix
    ./wofi.nix
    ./kitty.nix
    ./waybar.nix
    ./swaync.nix
    ./firefox.nix
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
      gnome.seahorse
      gnome.dconf-editor
      gnome.adwaita-icon-theme
      gnome.nautilus
      gnome.geary
      qalculate-gtk
      gcr
      gsettings-desktop-schemas
      wdisplays
      libnotify
      swaybg
      wlsunset
      brightnessctl
      pavucontrol
      obs-studio
      wl-clipboard
      libsForQt5.kdeconnect-kde
      darkman
      osu-lazer-bin
      libsecret
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

