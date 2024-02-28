# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }: {
  imports = [
    ../../modules/nix.nix
    ../../modules/locale.nix
    ../../modules/greetd.nix
    ../../modules/android.nix
    ../../modules/hardware.nix
    ../../modules/pipewire.nix
    ../../modules/bluetooth.nix
    ../../modules/networking.nix
    ../../modules/home-manager.nix
    ../../modules/power-management.nix
    ./hardware.nix
  ];

  networking.hostName = "aspire";
  programs.hyprland.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "boot.shell_on_fail"
    ];
    loader = {
      timeout = 0;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
        consoleMode = "max";
      };
    };
  };
  
  hardware = {
    opentabletdriver.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  security = {
    tpm2.enable = true;
    polkit.enable = true;
    pam.services.gtklock = { };
  };

  services = {
    fwupd.enable = true;
    ddccontrol.enable = true;
    gnome = {
      gnome-online-accounts.enable = true;
      gnome-keyring.enable = true;
      at-spi2-core.enable = true;
    };
  };

  programs = {
    dconf.enable = true;
    seahorse.enable = true;
    zsh.enable = true;
    geary.enable = true;
    kdeconnect.enable = true;
    firefox.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;
    users.caio = {
      hashedPassword = "$y$j9T$LWmQJtK.SNsnZPz3Ou15N1$3iRtBCYmnRq/zazbnPCpp63WMYDpywJ6emx43d9SUF0";
      isNormalUser = true;
      description = "Caio Muniz";
      extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
    };
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    fira
  ];

  xdg.portal.extraPortals = with pkgs; [
    gnome.gnome-keyring
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
  ];

  environment = {
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      SDL_VIDEODRIVER = "wayland";
    };
    pathsToLink = [ "/share/zsh" ];
    shells = [ pkgs.zsh ];
  };
  system.stateVersion = "22.11";
}
