{ user, ... }:
{
  imports = [
    ./desktop
    ./shell
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
