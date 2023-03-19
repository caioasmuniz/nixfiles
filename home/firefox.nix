{ ... }: {
  home.file."firefox-gnome-theme" = {
    target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
    source = fetchTarball {
      url = "https://github.com/rafaelmardojai/firefox-gnome-theme/archive/master.tar.gz";
      sha256 = "0dh6zif8s7wyx0nw6h27d32w49qbkrl5caymaafakvahylf050dc";
    };
  };
  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
      };
      userChrome = ''@import "firefox-gnome-theme/userChrome.css";'';
      userContent = ''@import "firefox-gnome-theme/userContent.css";'';
    };
  };
}
