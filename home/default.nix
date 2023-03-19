{ config, pkgs, inputs, ... }: {
  
  imports = [
    ./zsh.nix
    ./xdg.nix
    ./hyprland.nix
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
      swayidle
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
    ];
  };
  home.file."firefox-gnome-theme" = {
    target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
    source = fetchTarball {
      url = "https://github.com/rafaelmardojai/firefox-gnome-theme/archive/master.tar.gz";
      sha256 = "0dh6zif8s7wyx0nw6h27d32w49qbkrl5caymaafakvahylf050dc";
    };
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
      {
        event = "lock";
        command = "${pkgs.gtklock}/bin/gtklock";
      }
    ];
    timeouts = [
      {
        timeout = 310;
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
      # {
      #   timeout = 310;
      #   command = ''
      #     ${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.gnugrep}/bin/grep running
      #     if [ $? == 1 ]; then
      #       ${pkgs.systemd}/bin/systemctl suspend
      #     fi
      #     '';
      # }
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
    firefox = {
      enable = true;
      profiles.default = {
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "svg.context-properties.content.enabled" = true;
        };
        userChrome = ''@import "firefox-gnome-theme/userChrome.css";'';
        userContent = ''@import "firefox-gnome-theme/userContent.css";'';
      };
    };
  };
}

