# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  lib,
  user,
  ...
}:
{
  imports = [
    ./ssh.nix
    ./nix.nix
    ./locale.nix
    ./greetd.nix
    ./nautilus.nix
    ./zramswap.nix
    ./pipewire.nix
    ./networking.nix
    ./home-manager.nix
    ./power-management.nix
  ];

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
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  security = {
    tpm2.enable = true;
    polkit.enable = true;
  };

  services = {
    upower.enable = true;
    fwupd.enable = true;
    ddccontrol.enable = true;
    tailscale.enable = true;
    gnome = {
      gnome-online-accounts.enable = true;
      gnome-keyring.enable = true;
      at-spi2-core.enable = true;
    };
  };

  programs = {
    hyprland.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    # zsh.enable = true;
    fish.enable = true;
    geary.enable = true;
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
    };
  };

  users = {
    # defaultUserShell = pkgs.zsh;
    mutableUsers = false;
    users.${user} = {
      hashedPassword = "$y$j9T$LWmQJtK.SNsnZPz3Ou15N1$3iRtBCYmnRq/zazbnPCpp63WMYDpywJ6emx43d9SUF0";
      isNormalUser = true;
      description = "Caio Muniz";
      extraGroups = [ "wheel" ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = lib.splitString "\n" (
        builtins.readFile ../hosts/inspiron/ssh_host_ed25519_key.pub
      );
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.commit-mono
    inter
    fira
  ];

  xdg.portal.extraPortals = with pkgs; [
    gnome-keyring
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
  ];

  environment = {
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      SDL_VIDEODRIVER = "wayland";
    };
    # pathsToLink = [ "/share/zsh" ];
    shells = [ pkgs.bashInteractive ];
  };
  system.stateVersion = "22.11";
}
