{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bottles
    pkgs.osu-lazer-bin
  ];
}
