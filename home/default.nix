{ user, ... }:
{
  imports = [
    ./desktop
    ./shell
    ./applications
  ];
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "22.11";
  };
}
