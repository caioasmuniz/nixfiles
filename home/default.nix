{ pkgs, inputs, ... }: {

  imports = [
    ./zsh.nix
    ./xdg.nix
    ./hyprland.nix
    ./firefox.nix
    ./swayidle.nix
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
      gsettings-desktop-schemas
      polkit_gnome
      qbittorrent
      wdisplays
      swaynotificationcenter
      libnotify
      gtklock
      swaybg
      wlsunset
      brightnessctl
      playerctl
      pavucontrol
      obs-studio
      wl-clipboard
      spotifywm
      libsForQt5.kdeconnect-kde
      fx_cast_bridge
      darkman
      wallutils
      vscode
      wofi
      kitty
      osu-lazer-bin
      bottles
      libsecret
      vulkan-tools
    ];
  };

  programs = {
    waybar = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.hostPlatform.system
      }.waybar-hyprland;
      # systemd.enable = true;
    };
    home-manager.enable = true;
  };
}

