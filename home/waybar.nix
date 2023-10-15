{ pkgs, lib, inputs, ... }: {
  programs.waybar = {
    enable = true;
    package = inputs.waybar.packages.${pkgs.system}.default;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    settings = {
      bar = {
        layer = "top";
        position = "top";
        spacing = 4;
        margin-top = 4;
        margin-left = 4;
        margin-right = 4;

        modules-left = [
          "custom/launcher"
          "group/hardware"
          "temperature"
          "custom/weather"
          "wlr/workspaces"
          # "hyprland/window"
          # "mpris"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "battery"
          "network"
          "wireplumber"
          "backlight"
          "tray"
          "network#vpn"
          "custom/darkman"
          "custom/powerprofiles"
          "custom/notification"
        ];

        backlight = {
          device = "intel_backlight";
          format = "{icon}<sup> </sup>";
          format-alt = "{icon} {percent}%";
          format-icons = [ "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨" ];
          on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl s 5%-";
          on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl s +5%";
          tooltip = true;
          scroll-step = 5.0;
          reverse-scrolling = true;
        };
        battery = {
          bat = "BAT0";
          format-alt = "{icon}<sup> </sup>{capacity}%";
          format = "{icon}";
          format-icons = {
            full = "󰂅";
            charging = [ "󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" ];
            discharging = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          };
          interval = 5;
          states = { critical = 10; warning = 25; normal = 26; normal2 = 89; good = 90; };
          tooltip = true;
          tooltip-format = "󰥔 {timeTo}\n {power} W  󰂎 {capacity}%";
        };
        clock = {
          format = "{:%H:%M 󰥔<sup> </sup>󰿟󰃭 %e %b}";
          format-calendar = "<span color='#f38ba8' font='FiraCode Nerd Font'><b>{}</b></span>";
          format-calendar-weekdays = "<span color='#f38ba8'font='FiraCode Nerd Font'><b>{}</b></span>";
          interval = 1;
          on-click = "${pkgs.gnome.gnome-calendar}/bin/gnome-calendar &";
          today-format = "<span color='#a6e3a1'><b><u>{}</u></b></span>";
          tooltip-format = "<big><b>󰥔 {:%H:%M:%S 󰃭 %B %Y}</b></big>\n<tt><big>{calendar}</big></tt>";
        };
        cpu = {
          format = "<small>CPU </small>{usage}%";
          interval = 5;
          states = { critical = 75; warning = 50; };
          tooltip-format = "{avg_frequency}";
        };
        "custom/launcher" = {
          format = "<big>󱄅</big><sup> </sup>";
          on-click = "pkill wofi || ${pkgs.wofi}/bin/wofi -n -s ~/.config/wofi/style.css";
          tooltip = false;
        };
        "custom/darkman" = {
          exec = ''
            state=$(${pkgs.darkman}/bin/darkman get)
            if [[ $state == "light" ]];
            then
                echo ""
            else
                echo ""
            fi'';
          format = "{}<sup> </sup>";
          interval = 5;
          on-click = "${pkgs.darkman}/bin/darkman toggle";
          tooltip = false;
        };
        "custom/powerprofiles" = {
          exec = ''
            state=$(${pkgs.power-profiles-daemon}/bin/powerprofilesctl get)
            if [[ $state == "power-saver" ]]; then
                echo "󰌪"
            elif [[ $state == "balanced" ]]; then
                echo "󰗑"
            else
                echo "󰓅"
            fi'';
          format = "{}<sup> </sup>";
          interval = 5;
          on-click = ''
            state=$(${pkgs.power-profiles-daemon}/bin/powerprofilesctl get)
            if [[ $state == "power-saver" ]]; then
                ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced
            elif [[ $state == "balanced" ]]; then
                ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance
            else
                ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver
            fi'';
          tooltip = false;
        };
        "custom/notification" = {
          escape = true;
          exec = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
          exec-if = "which ${pkgs.swaynotificationcenter}/bin/swaync-client";
          format = "{icon}<span foreground='red'><sup><b> {}</b></sup></span>";
          format-icons = {
            none = "󰍡";
            dnd-none = "󱙍";
            notification = "󰍡";
            dnd-notification = "󱙍";
          };
          on-click = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
          on-click-right = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
          return-type = "json";
          tooltip = false;
        };
        "custom/weather" = {
          exec = lib.getExe pkgs.wttrbar;
          format = "{}°C";
          interval = 3600;
          return-type = "json";
          tooltip = true;
          on-click = "${pkgs.gnome.gnome-weather}/bin/gnome-weather &";
        };
        "group/hardware" = {
          orientation = "vertical";
          modules = [
            "cpu"
            "memory"
          ];
        };
        "hyprland/submap" = {
          format = "✌️ {}";
          max-length = 8;
          tooltip = true;
        };
        "hyprland/window" = {
          format = "";
        };

        "hyprland/workspaces" = {
          format = "{icon}{name}: {windows} ";
          format-icons = { special = "󰣆 "; default = ""; };
          window-rewrite-default = "";
          window-rewrite = {
            "class<kitty>" = "";
            "class<firefox>" = "<span color='#D65126'>󰈹</span>";
            "class<code-url-handler>" = "<span color='#0073B7'>󰨞</span>";
            "class<org.gnome.Nautilus>" = "󰪶";
            "class<com.usebottles.bottles>" = "󱄮";
            "class<qalculate-gtk>" = "󰃬";
            "class<osu!>" = "󰊗";
            "class<com.obsproject.Studio>" = "󱜠";
            "class<virt-manager>" = "";
            "class<chromium-browser>" = "󰊯";
            "class<mpv>" = "󰐌";
            "class<swaync>" = "󰂚";
            "class<wofi>" = "󰌧";
            "class<pavucontrol>" = "󰕾";
            "class<jetbrains-studio>" = "<span color='#3DDC84'>󰀲</span>";
            "class<firefox> title<.*github.*>" = "󰊤";
            "class<firefox> title<.*twitch.*>" = "<span color='purple'>󰕃</span>";
            "class<firefox> title<.*youtube.*>" = "<span color='red'>󰗃</span>";
            "class<firefox> title<.*spotify.*>" = "<span color='green'>󰓇</span>";
            "class<firefox> title<.*whatsapp.*>" = "<span color='green'>󰖣</span>";
            "class<firefox> title<.*discord.*>" = "<span color='darkblue'>󰙯</span>";
            "class<firefox> title<.*reddit.*>" = "<span color='#FF4400'>󰑍</span>";
          };
          format-window-separator = " ";
          show-special = true;
          on-scroll-down = "hyprctl dispatch workspace e-1";
          on-scroll-up = "hyprctl dispatch workspace e+1";
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        memory = {
          format = "<small>RAM </small>{}%";
          interval = 5;
          on-click = "${pkgs.kitty}/bin/kitty ${pkgs.btop}/bin/btop &";
          states = { critical = 75; warning = 50; };
        };
        mpris = {
          format = "{player_icon} {dynamic}";
          ignored-players = [ "firefox" ];
          player-icons = {
            default = "";
            firefox = "󰈹 ";
            spotify = "󰓇 ";
          };
          status-icons = {
            paused = "";
            playing = "";
            stopped = "";
          };
        };
        network = {
          format = "{icon}<sup> </sup>";
          format-alt = "{icon} {signalStrength}%  {bandwidthUpBytes}  {bandwidthDownBytes}";
          format-disconnected = "󰤮<sup> </sup>";
          format-icons = {
            ethernet = "󰈀";
            wifi = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          };
          interval = 5;
          tooltip-format-disconnected = "Disconnected";
          tooltip-format-ethernet = "󰈀 {ifname}  爵 {ipaddr}\n {bandwidthUpBytes}   {bandwidthDownBytes}";
          tooltip-format-wifi = "{icon} {essid}\n爵 {ipaddr}  鷺 {signaldBm}dBm\n {bandwidthUpBytes}   {bandwidthDownBytes}";
        };
        "network#vpn" = {
          format = "󱇱<sup> </sup>";
          interface = "wg0";
          interval = 5;
          tooltip-format = "VPN Connected: {ipaddr}";
          on-click = ''
            if [[ $(${pkgs.networkmanager}/bin/nmcli device status | ${pkgs.gnugrep}/bin/grep wg0 | ${pkgs.gnugrep}/bin/grep connected) == "" ]]
            then
            ${pkgs.networkmanager}/bin/nmcli connection up wg0
            else
            ${pkgs.networkmanager}/bin/nmcli connection down wg0
            fi'';
        };
        pulseaudio = {
          format = "{icon}";
          format-alt = "{icon}<sup> </sup>{volume}%";
          format-bluetooth = "{icon} 󰂯";
          format-muted = "󰝟";
          format-icons = {
            default = [ "󰕿" "󰖀" "󰕾" ];
            headphones = "";
            phone = "";
          };
          on-right-click = "${lib.getExe pkgs.pavucontrol} -t 3";
        };
        temperature = {
          thermal-zone = 1;
          # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          format = "{icon}<sup> </sup>{temperatureC}°C";
          format-icons = [ "" "" "" "" "" ];
          critical-threshold = 45;
        };
        tray = {
          icon-size = 20;
          show-passive-items = true;
          spacing = 4;
        };
        wireplumber = {
          format = "{icon}";
          format-alt = "{icon}<sup> </sup>{volume}%";
          format-icons = [ "󰕿" "󰖀" "󰕾" ];
          format-muted = "󰝟";
          on-scroll-up = "${pkgs.swayosd}/bin/swayosd --output-volume raise 5";
          on-scroll-down = "${pkgs.swayosd}/bin/swayosd --output-volume lower 5";
          on-click = "pkill pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol -t 3";
        };
        "wlr/taskbar" = {
          format = "{icon}";
          icon-size = 18;
          markup = true;
          on-click = "activate";
          on-click-middle = "close";
          tooltip-format = "{title}";
        };
        "wlr/workspaces" = {
          format = "{name}";
          on-click = "activate";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          on-scroll-up = "hyprctl dispatch workspace e+1";
        };
      };
    };
    style = ''
      /* Reset all styles */
      * {
        border: none;
        border-radius: 0;
        min-height: 0;
        margin: 0;
        padding: 0;
      }

      tooltip {
        background-color: @theme_bg_color;
        border: @borders solid 1px;
        border-radius: 12px;
        text-shadow: none;
      }

      tooltip label {
        color: @theme_text_color;
      }

      /* The whole bar */
      #waybar {
        /* background: rgba(17, 17, 27, 0.3); */
        background: rgba(0, 0, 0, 0);
        color: @theme_text_color;
        font-family: Fira Code Nerd Font;
        font-size: 12px;
        min-height: 32px;
      }

      window#waybar.solo {
        background-color: @theme_bg_color;
      }

      #cpu,
      #memory,
      #battery,
      #backlight,
      #clock,
      #taskbar,
      #pulseaudio,
      #wireplumber,
      #workspaces button,
      #network,
      #network.disconnected.vpn,
      #custom-weather,
      #custom-launcher,
      #custom-notification,
      #custom-darkman,
      #custom-powerprofiles,
      #mpris,
      #temperature,
      #idle_inhibitor,
      #tray {
        transition: all 0.5s cubic-bezier(0.55, -0.68, 0.48, 1.68);
        border-radius: 12px;
        border: 1px solid @borders;
        padding: 0px 8px;
        margin: 0px;
        background-color: @theme_base_color;
        color: @theme_text_color;
        font-weight: bold;
      }

      #hardware {
        padding: 0px;
        font-size: 9px;
        font-weight: normal;
      }

      #cpu {
          border-radius: 12px 12px 0px 0px;
      }

      #memory {
        border-radius: 0px 0px 12px 12px;
        border-top: none;
      }

      #cpu.warning,
      #memory.warning,
      #battery.warning.discharging {
        background-color: @warning_color;
        color: @theme_bg_color;
      }

      #cpu.critical,
      #memory.critical,
      #pulseaudio.muted,
      #wireplumber.muted,
      #temperature.critical,
      #workspaces button.urgent,
      #battery.critical.discharging {
        background-color: @error_color;
        color: @theme_bg_color;
      }

      #cpu.good,
      #memory.good,
      #network.vpn,
      #battery.good,
      #battery.full,
      #taskbar button.active,
      #workspaces button.active {
        background-color: @success_color;
        color: @theme_text_color;
      }

      #window {
        font-weight: bold;
      }

      #workspaces {
        padding: 0px;
        background-color: transparent;
      }

      #workspaces button {
        padding: 0px 4px;
        margin-right: 4px;
      }

      #workspaces button:hover {
        background-color: @theme_selected_bg_color;
        color: @theme_text_color;
        border-radius: 12px;
      }
    '';
  };
}

