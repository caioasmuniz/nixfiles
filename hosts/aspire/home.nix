{ inputs, lib, ... }:
{
  imports = [
    inputs.vscode-server.homeModules.default
    ../../home
    ../../home/applications/gaming.nix
  ];

  services = {
    hypridle.enable = lib.mkForce false;
    vscode-server.enable = true;
  };
}
