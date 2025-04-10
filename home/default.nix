{ ... }:
{
  imports = [
    ./desktop
    ./fish.nix
    ./ssh.nix
    ./ghostty.nix
    ./gaming.nix
    ./firefox.nix
    ./vscode.nix
  ];
  home = {
    username = "caio";
    homeDirectory = "/home/caio";
    stateVersion = "22.11";
  };
}
