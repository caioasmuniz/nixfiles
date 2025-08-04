{ inputs, lib, ... }:
{
  imports = [
    inputs.vscode-server.homeModules.default
    ../../home
  ];
 
  services = {
    hypridle.enable = lib.mkForce false;
    vscode-server.enable = true;
  };
}
