{ user, ... }:
{
  services.gvfs.enable = true;
  programs.kdeconnect.enable = true;
  users.users.${user}.extraGroups = [ "adbusers" ];
}
