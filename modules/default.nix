# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
let
  swayConfig = pkgs.writeText "greetd-sway-config" ''
    exec "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP"
    input "type:touchpad" {
      tap enabled
    }
    xwayland disable
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
    exec "regreet; swaymsg exit"
  '';
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./regreet.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    initrd.systemd.enable = true;
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "quiet" "splash" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" "boot.shell_on_fail" ];
    plymouth = {
      enable = true;
    };
    loader = {
      timeout = 0;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Sao_Paulo";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    # console.keyMap = "br-abnt2";
    extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
  };

  sound.enable = true;

  hardware = {
    pulseaudio.enable = false;
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services.greetd.enableGnomeKeyring = true;
    pam.services.gtklock = { };
  };

  services = {
    fwupd.enable = true;
    power-profiles-daemon.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session.command = "${pkgs.sway}/bin/sway --config ${swayConfig}";
        initial_session = {
          command = "${inputs.hyprland.packages.${pkgs.hostPlatform.system}.default}/bin/Hyprland";
          user = "caio";
        };
      };
    };
    gnome = {
      evolution-data-server.enable = true;
      gnome-online-accounts.enable = true;
      gnome-keyring.enable = true;
      at-spi2-core.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true;
    };
  };

  programs = {
    adb.enable = true;
    kdeconnect.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    regreet = {
      enable = true;
      package = pkgs.greetd.regreet;
      settings = {
        GTK = {
          cursor_theme_name = "Adwaita";
          font_name = "Fira Sans 12";
          icon_theme_name = "Adwaita";
          theme_name = "Adwaita-dark";
        };
      };
    };
  };

  qt.platformTheme = "qt5ct";

  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;
    users.caio = {
      hashedPassword = "$y$j9T$LWmQJtK.SNsnZPz3Ou15N1$3iRtBCYmnRq/zazbnPCpp63WMYDpywJ6emx43d9SUF0";
      isNormalUser = true;
      description = "Caio Muniz";
      extraGroups = [ "networkmanager" "wheel" "audio" "adbusers" ];
      shell = pkgs.zsh;
      packages = with pkgs; [
        firefox-wayland
        vscode
        wofi
        kitty
        osu-lazer-bin
        bottles
        libsecret
        gamescope
        vulkan-tools
      ];
    };
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    fira
  ];
  nixpkgs = {
    config.allowUnfree = true;
    config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    };
  };

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  environment = {
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      XDG_CURRENT_DESKTOP = "hyprland";
    };
    systemPackages = with pkgs; [
      zsh
      qt5ct
      micro
      git
      nil
      nixpkgs-fmt
      glib
      gnome.adwaita-icon-theme
      power-profiles-daemon
      plymouth
      greetd.greetd
      greetd.regreet
      sway
    ];
    pathsToLink = [ "/share/zsh" ];
    shells = [ pkgs.zsh ];
  };
  system.stateVersion = "22.11"; # Did you read the comment?
}


