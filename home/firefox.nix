{ inputs, ... }:
{
  home.file."firefox-gnome-theme" = {
    target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
    source = inputs.firefox-gnome-theme;
  };
  programs.firefox = {
    enable = true;
    profiles.default = {
      search = {
        default = "DuckDuckGo";
        force = true;
      };
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
      };
      userChrome = ''@import "firefox-gnome-theme/userChrome.css";'';
      userContent = ''@import "firefox-gnome-theme/userContent.css";'';
    };
  };
}
