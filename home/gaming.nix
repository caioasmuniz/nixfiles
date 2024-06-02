{ inputs, pkgs, ... }: {
  home.packages = with pkgs; [
    bottles
    osu-lazer-bin
  ];
}
