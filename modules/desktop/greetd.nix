{ pkgs, lib, ... }: {
  security.pam.services.greetd.enableGnomeKeyring = true;
  environment.systemPackages = [ pkgs.adwaita-icon-theme ];

  programs.regreet = {
    enable = true;
    cageArgs = [ "-s" "-d" "-m" "last" ];
    settings.GTK = {
      cursor_theme_name = "Adwaita";
      font_name = lib.mkForce "Fira Sans 12";
      icon_theme_name = "Adwaita";
    };
  };
}
