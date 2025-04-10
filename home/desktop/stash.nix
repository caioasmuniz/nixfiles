{ inputs, ... }:
{
  imports = [ inputs.stash.homeManagerModules.default ];
  programs.stash = {
    enable = true;
    systemd.enable = true;
    hyprland = {
      binds.enable = true;
      blur.enable = true;
    };
  };
}
