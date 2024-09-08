{ inputs, pkgs, ... }: {
  imports = [ inputs.ags.homeManagerModules.default ];
  home.packages = with pkgs; [ bun brightnessctl ];
  programs.ags = {
    enable = true;
    configDir= ../ags;

    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
      
    ];

  };
  wayland.windowManager.hyprland.extraConfig = ''
    exec=ags

    layerrule=blur,osd
    layerrule=ignorezero,osd
    
    bind=SUPER,w,exec, ags -t bar-0;ags -t bar-1
    layerrule=blur,bar
    layerrule=ignorezero,bar
    
    bind=SUPER,Space,exec, ags -t applauncher
    layerrule=blur,applauncher
    layerrule=ignorezero,applauncher
    
    bind=SUPER,n,exec, ags -t quicksettings
    layerrule=blur,quicksettings
    layerrule=ignorezero,quicksettings
  '';
}
