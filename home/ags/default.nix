{ inputs, pkgs, ... }:
{
  imports = [ inputs.ags.homeManagerModules.default ];
  home.packages = with pkgs; [ brightnessctl ];
  programs.ags = {
    enable = true;
    configDir = ../ags;
    systemd.enable = true;

    # additional packages to add to gjs's runtime
    extraPackages = with inputs.ags.packages.${pkgs.system}; [
      apps
      battery
      bluetooth
      hyprland
      mpris
      network
      notifd
      powerprofiles
      tray
      wireplumber
    ];

  };
  wayland.windowManager.hyprland.extraConfig = ''
    layerrule=blur,gtk-layer-shell
    layerrule=ignorezero,gtk-layer-shell
      
    bind=SUPER,Space,exec, ags toggle applauncher
    bind=SUPER,n,exec, ags toggle quicksettings
    bind=SUPERSHIFT,n,exec, ags toggle infopannel
  '';
}
