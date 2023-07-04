{ pkgs, lib, ... }: {
  home.packages = [
    (pkgs.rustPlatform.buildRustPackage
      rec {
        pname = "hyprland-autoname-workspaces";
        version = "1.0.0";

        src = pkgs.fetchFromGitHub {
          owner = "hyprland-community";
          repo = pname;
          rev = version;
          sha256 = "+oJWPSN6VmUUpd5ZLrN5Sa9Yg6pqVlaQFSRnEkLpLt8=";
        };

        cargoSha256 = "wXQVcTQ6up34ZqJP5hDttFEqtz+hmyd1aWFnPlFvazA=";

        nativeBuildInputs = with pkgs; [ pkg-config ];
        buildInputs = with pkgs; [ gcc ];

        meta = with lib; {
          description = "This app automatically rename workspaces with icons of started applications - tested with waybar.";
          homepage = "https://github.com/hyprland-community/hyprland-autoname-workspaces";
          license = licenses.isc;
        };
      })
  ];
  wayland.windowManager.hyprland.extraConfig = ''      exec-once=hyprland-autoname-workspaces &
  '';

  xdg.configFile."hyprland-autoname-workspaces/config.toml".text = ''
    [format]
    # Deduplicate icons if enable.
    # A superscripted counter will be added.
    dedup = true
    # window delimiter
    delim = " "

    # available formatter:
    # {counter_sup} - superscripted count of clients on the workspace, and simple {counter}, {delim}
    # {icon}, {client}
    # workspace formatter
    workspace = "{id}: {clients}<sup> </sup>" # {id}, {delim} and {clients} are supported
    workspace_empty = "{id}"                  # {id}, {delim} and {clients} are supported
    # client formatter
    client = "{icon}"
    client_active = "<span size='x-large'>{icon}</span>"

    # deduplicate client formatter
    # client_fullscreen = "[{icon}]"
    client_dup = "{client}<sup> {counter}</sup>"
    # client_dup_fullscreen = "[{icon}]{delim}{icon}{counter_unfocused}"
    # client_dup_active = "{client}<sup> {counter}</sup>"

    [icons]
    # Add your icons mapping
    # use double quote the key and the value
    # take class name from 'hyprctl clients'
    "DEFAULT" = " {class}: {title}"
    "(?i)Kitty" = ""
    "[Ff]irefox" = "<span color='#D65126'>󰈹</span>"
    "code-url-handler" = "<span color='#0073B7'>󰨞</span>"
    "org.gnome.Nautilus" = "󰪶"
    "com.usebottles.bottles" = "󱄮"
    "qalculate-gtk" = "󰃬"
    "osu!" = "󰊗"
    "com.obsproject.Studio" = "󱜠"
    "virt-manager" = ""
    "chromium-browser" = "󰊯"
    "mpv" = "󰐌"
    "swaync" = "󰂚"
    "wofi" = "󰌧"

    [icons_active]
    "DEFAULT" = " {class}: {title}"

    [title."(?i)kitty"]
    "(?i)neomutt" = "neomutt"

    [title."(?i)firefox"]
    "(?i)twitch" = "<span color='purple'>󰕃</span>"
    "(?i)youtube" = "<span color='red'>󰗃</span>"
    "(?i)spotify" = "<span color='green'>󰓇</span>"
    "(?i)whatsapp" = "<span color='green'>󰖣</span>"
    "(?i)discord" = "<span color='darkblue'>󰙯</span>"
    "(?i)reddit" = "<span color='#FF4400'>󰑍</span>"

    # Add your applications that need to be exclude
    # The key is the class, the value is the title.
    # You can put an empty title to exclude based on
    # class name only, "" make the job.
    [exclude]
    "(?i)fcitx" = ".*"            # will match all title for fcitx
    "(?i)TestApp" = ""            # will match all title for TestApp
    aProgram = "^$"               # will match null title for aProgram
    "[Ss]team" = "Friends List.*"
    # "[Ss]team" = "^$"             # will match all Steam window with null title (some popup)  
  '';
}
