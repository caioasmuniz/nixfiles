{ inputs, pkgs, ... }: {
  home.packages = with pkgs; [
    steam
    bottles
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
  ];
}
