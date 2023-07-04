{ pkgs, ... }: {
  home.file."firefox-gnome-theme" = {
    target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
    source = pkgs.fetchFromGitHub {
      owner = "rafaelmardojai";
      repo = "firefox-gnome-theme";
      rev = "v114";
      sha256 = "o53fws/jwhLfxiYfTyYpKSGi61d5LHzGgSCkt3DNGRI=";
    };
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
