{ inputs, pkgs, ... }: {
  imports = [ inputs.ags.homeManagerModules.default ];
  home.packages = [ pkgs.bun ];
  programs.ags = {
    enable = true;
    configDir= ../ags;

    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
      pavucontrol
    ];

  };
  wayland.windowManager.hyprland.extraConfig = ''
    exec=ags
    bind=SUPER,Space,exec, ags -t applauncher
    #layerrule=blur,applauncher
    #layerrule=blur,quicksettings
  '';
}
