{ inputs, pkgs, ... }: {
  home.packages = [
    pkgs.steam
    pkgs.bottles
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
  ];
}
