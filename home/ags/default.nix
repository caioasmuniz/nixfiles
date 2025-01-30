{ inputs, pkgs, ... }:
{
  imports = [ inputs.ags.homeManagerModules.default ];
  home.packages = with pkgs; [
    brightnessctl
    nixos-icons
  ];
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
      pkgs.libgtop
    ];

  };
  wayland.windowManager.hyprland.extraConfig = ''
    layerrule=blur,gtk-layer-shell
    layerrule=ignorezero,gtk-layer-shell

    layerrule=blur,gtk4-layer-shell
    layerrule=ignorezero,gtk4-layer-shell
     
      
    bind=SUPER,Space,exec, ags toggle applauncher
    bind=SUPER,n,exec, ags toggle quicksettings
    bind=SUPERSHIFT,n,exec, ags toggle infopannel
  '';
}
