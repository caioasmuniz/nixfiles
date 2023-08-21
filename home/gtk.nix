{ pkgs, ... }: {
  gtk = {
    enable = true;
    font = {
      package = pkgs.fira;
      name = "Fira Sans Regular";
      size = 10;
    };
    cursorTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
    };
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
    theme = {
      package = pkgs.gnome.gnome-themes-extra;
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
