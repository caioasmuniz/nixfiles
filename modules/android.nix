{ ... }: {
  services.gvfs.enable = true;
  programs = {
    adb.enable = true;
    kdeconnect.enable = true;
  };
  users.users.caio.extraGroups = [ "adbusers" ];
}