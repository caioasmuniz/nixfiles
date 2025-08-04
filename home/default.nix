{ user, ... }:
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
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "22.11";
  };
}
