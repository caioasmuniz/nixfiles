{ pkgs, ... }: {
  security.pam.services.greetd.enableGnomeKeyring = true;
  environment.systemPackages = [ pkgs.gnome.adwaita-icon-theme ];

  programs.regreet = {
    enable = true;
    cageArgs = [ "-s" "-d" "-m" "last" ];
    settings.GTK = {
      cursor_theme_name = "Adwaita";
      font_name = "Fira Sans 12";
      icon_theme_name = "Adwaita";
    };
  };
}
