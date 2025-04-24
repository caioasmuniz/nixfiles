{ ... }:
{
  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
    };
  };
  hardware = {
    opentabletdriver.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
