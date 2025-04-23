# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  user,
  ...
}:
{
  imports = [
    ./ssh.nix
    ./nix.nix
    ./boot.nix
    ./locale.nix
    ./greetd.nix
    ./nautilus.nix
    ./zramswap.nix
    ./pipewire.nix
    ./networking.nix
    ./home-manager.nix
    ./power-management.nix
  ];

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
    mutableUsers = false;
    users.${user} = {
      hashedPassword = "$y$j9T$LWmQJtK.SNsnZPz3Ou15N1$3iRtBCYmnRq/zazbnPCpp63WMYDpywJ6emx43d9SUF0";
      isNormalUser = true;
      description = "Caio Muniz";
      extraGroups = [ "wheel" ];
      shell = pkgs.fish;
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
    shells = [ pkgs.bashInteractive ];
  };
  system.stateVersion = "22.11";
}
