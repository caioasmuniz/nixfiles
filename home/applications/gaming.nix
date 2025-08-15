{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bottles
    osu-lazer-bin
    hydralauncher
    (vintagestory.overrideAttrs (
      old: new: {
        postInstall = ''
          rm $out/share/vintagestory/VintagestoryLib.dll

          cp ${./VintagestoryLib.dll} $out/share/vintagestory/VintagestoryLib.dll
        '';
      }
    ))
  ];
}
