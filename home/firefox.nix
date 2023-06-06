{ pkgs, ... }: {
  home.file."firefox-gnome-theme" = {
    target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
    source = pkgs.fetchFromGitHub {
          owner = "rafaelmardojai";
          repo = "firefox-gnome-theme";
          rev = "v113";
          sha256 = "c1TTeZUVI4FPSTGJPBucELnzYr96IF+g++9js3eJvm8=";
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
