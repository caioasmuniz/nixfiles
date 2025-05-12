{ pkgs, ... }: {
  home.sessionVariables = { ADW_DISABLE_PORTAL = 1; };
  gtk = {
    enable = true;
    font = {
      package = pkgs.inter;
      name = "Inter";
      size = 10;
    };
    cursorTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
    };
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita";
    };
  };
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/wm/preferences".button-layout = ":";
    };
  };
}
