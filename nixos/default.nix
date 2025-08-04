# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, user, ... }:
{
  imports = [
    ./ssh.nix
    ./nix.nix
    ./boot.nix
    ./fish.nix
    ./locale.nix
    ./zramswap.nix
    ./networking.nix
    ./power-management.nix
  ];

  security = {
    tpm2.enable = true;
    polkit.enable = true;
  };

  services = {
    fwupd.enable = true;
    tailscale.enable = true;
  };

  environment.shells = [ pkgs.bashInteractive ];

  users = {
    mutableUsers = false;
    users.${user} = {
      hashedPassword = "$y$j9T$LWmQJtK.SNsnZPz3Ou15N1$3iRtBCYmnRq/zazbnPCpp63WMYDpywJ6emx43d9SUF0";
      isNormalUser = true;
      description = "Caio Muniz";
      extraGroups = [ "wheel" ];
    };
  };

  system.stateVersion = "22.11";
}
