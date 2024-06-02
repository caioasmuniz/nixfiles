{ inputs, pkgs, ... }: {
  home.packages = with pkgs; [
    bottles
   ( inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin.override
    { gmrun_enable = false; })
  ];
}
