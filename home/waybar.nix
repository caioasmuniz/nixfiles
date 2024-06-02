{ pkgs, config, lib, ... }: {
  programs.waybar = {
    enable = true;
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
          "group/workspaces"
        ];
        modules-center = [
          "group/group-clockweather"
        ];
        modules-right = [
          "battery"
          "group/group-network"
          "group/group-audio"
          "group/group-backlight"
          "group/group-quicksettings"
        ];

        "group/group-backlight" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "";
            transition-left-to-right = false;
          };
          modules = [
            "backlight"
            "backlight/slider"
          ];
        };
        "backlight/slider" = {
          device = "intel_backlight";
          orientation = "horizontal";
        };

        backlight = {
          device = "intel_backlight";
          format = "{icon}<sup> </sup>";
          format-alt = "{icon} {percent}%";
          format-icons = [ "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨" ];
          on-scroll-down = "${config.services.swayosd.package}/bin/swayosd-client --brightness raise";
          on-scroll-up = "${config.services.swayosd.package}/bin/swayosd-client --brightness lower";
          tooltip = true;
          tooltip-format = "{icon}  {percent}%";
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
          tooltip-format = "󰥔  {time}\n {power} W  󰂎 {capacity}%";
        };

        "group/group-clockweather" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 350;
            children-class = "child-clock-weather";
            transition-left-to-right = false;
          };
          modules = [
            "clock"
            "custom/weather"
            "clock#date"
          ];
        };

        clock = {
          format = "{:%H:%M}";
          interval = 30;
        };

        "clock#date" = {
          format = "󰃭 {:%e %b}";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "month";
            weeks-pos = "";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click = "${pkgs.gnome.gnome-calendar}/bin/gnome-calendar &";
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        "custom/weather" = {
          exec = lib.getExe pkgs.wttrbar;
          format = "{}°C";
          interval = 3600;
          return-type = "json";
          tooltip = true;
          on-click = "${pkgs.gnome.gnome-weather}/bin/gnome-weather &";
        };

        "group/group-quicksettings" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "not-power";
            transition-left-to-right = false;
          };
          modules = [
            "custom/notification"
            "custom/power"
            "custom/lock"
            "custom/reboot"
            "custom/darkman"
            "power-profiles-daemon"
            "tray"
          ];
        };

        "custom/notification" = {
          exec = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
          exec-if = "which ${pkgs.swaynotificationcenter}/bin/swaync-client";
          format = "{icon}<span foreground = 'red'> <sup><b>{}</b></sup></span>";
          #format = "{icon}<span foreground = 'red' > <sup> <b> { } </b> </sup> </span> ";
          format-icons = {
            none = "󰍡";
            dnd-none = "󱙍";
            notification = "󰍡";
            dnd-notification = "󱙍";
          };
          on-click = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
          on-click-right = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
          return-type = "json";
          tooltip = true;
        };

        "custom/power" = {
          format = "󰐥";
          tooltip = false;
          on-click = "systemctl poweroff";
        };

        "custom/reboot" = {
          format = "󰑓";
          tooltip = false;
          on-click = "systemctl reboot";
        };

        "custom/lock" = {
          format = "󰌾";
          tooltip = false;
          on-click = "${lib.getExe pkgs.gtklock}";
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
        power-profiles-daemon = {
          format = "{icon}";
          tooltip = true;
          tooltip-format = "{icon} {profile}";
          format-icons = {
            power-saver = "󰌪";
            balanced = "󰗑";
            performance = "󰓅";
          };
        };

        tray = {
          icon-size = 20;
          show-passive-items = true;
          spacing = 4;
        };

        privacy = {
          icon-spacing = 4;
          icon-size = 18;
          transition-duration = 250;
          modules = [
            {
              type = "screenshare";
              tooltip = true;
              tooltip-icon-size = 24;
            }
            {
              type = "audio-in";
              tooltip = true;
              tooltip-icon-size = 24;
            }
          ];
        };

        "custom/launcher" = {
          format = "<big>󱄅</big><sup> </sup>";
          on-click = "pkill wofi || ${pkgs.wofi}/bin/wofi";
          tooltip = false;
        };

        "group/hardware" = {
          orientation = "horizontal";
          modules = [
            "group/cpu_ram"
            "group/disk_temp"
          ];
        };

        "group/cpu_ram" = {
          orientation = "vertical";
          modules = [
            "cpu"
            "memory"
          ];
        };

        "group/disk_temp" = {
          orientation = "vertical";
          modules = [
            "disk"
            "temperature"
          ];
        };

        cpu = {
          format = "<small>CPU </small>{usage}%";
          interval = 5;
          states = { critical = 75; warning = 50; };
          tooltip-format = "{avg_frequency}";
        };

        memory = {
          format = "<small>RAM </small>{}%";
          interval = 5;
          on-click = "${pkgs.kitty}/bin/kitty ${pkgs.btop}/bin/btop &";
          states = { critical = 75; warning = 50; };
        };

        disk = {
          format = "<small>DISK </small>{percentage_used}%";
          tooltip-format = "{used} used out of {total} on {path} ({percentage_used}%)";
        };

        temperature = {
          thermal-zone = 2;
          format = "<small>TEMP </small>{temperatureC}°C";
          format-icons = [ "" "" "" "" "" ];
          critical-threshold = 45;
        };

        "hyprland/submap" = {
          format = "{}";
          max-length = 8;
          tooltip = true;
        };

        "group/workspaces" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "";
            transition-left-to-right = false;
          };
          modules = [
            "hyprland/workspaces"
            "hyprland/window"
          ];
        };

        "hyprland/window" = {
          format = "{class}";
        };

        "hyprland/workspaces" = {
          format = "{icon}{windows}<sup> </sup>";
          format-icons = { special = "󰣆 : "; default = ""; };
          window-rewrite-default = "";
          window-rewrite = {
            "class<kitty>" = "";
            "class<firefox>" = "<span color='#D65126'>󰈹</span>";
            "class<code-url-handler>" = "<span color='#0073B7'>󰨞</span>";
            "class<org.gnome.Nautilus>" = "󰪶";
            "class<com.usebottles.bottles>" = "󱄮";
            "class<steam>" = "󰓓";
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

        "group/group-network" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "";
            transition-left-to-right = false;
          };
          modules = [
            "network"
            "network#vpn"
            "network#stats"
          ];
        };

        network = {
          format = "{icon}<sup> </sup>";
          format-disconnected = "󰤮<sup> </sup>";
          format-icons = {
            ethernet = "󰈀";
            wifi = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          };
          interval = 5;
          tooltip-format = "{icon}  {essid}\n爵 {ipaddr}\n󱑽 {frequency}MHz  鷺 {signaldBm}dBm\n {bandwidthUpBytes}   {bandwidthDownBytes}";
          tooltip-format-ethernet = "󰈀 {ifname}  爵 {ipaddr}\n {bandwidthUpBytes}   {bandwidthDownBytes}";
          tooltip-format-disconnected = "Disconnected";
        };

        "network#stats" = {
          format = " {bandwidthUpBytes}  {bandwidthDownBytes}";
          interval = 5;
        };

        "network#vpn" = {
          format = "󱇱<sup> </sup>";
          interface = "wg0";
          interval = 5;
          tooltip-format = "VPN Connected: {ipaddr}";
          tooltip-format-disconnected = "Disconnected";
          on-click = ''
            if [[ $(${pkgs.networkmanager}/bin/nmcli device status | ${pkgs.gnugrep}/bin/grep wg0 | ${pkgs.gnugrep}/bin/grep connected) == "" ]]
            then
            ${pkgs.networkmanager}/bin/nmcli connection up wg0
            else
            ${pkgs.networkmanager}/bin/nmcli connection down wg0
            fi'';
        };

        "group/group-audio" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "";
            transition-left-to-right = false;
          };
          modules = [
            "wireplumber"
            "mpris"
            "pulseaudio/slider"
          ];
        };

        "pulseaudio/slider" = {
          "orientation" = "horizontal";
        };

        mpris = {
          format = "{player_icon} {dynamic}";
          dynamic-order = [ "title" "artist" "position" "length" "album" ];
          dynamic-importance-order = [ "position" "length" "title" "artist" "album" ];
          title-len = 30;
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

        wireplumber = {
          format = "{icon}";
          format-alt = "{icon}<sup> </sup>{volume}%";
          format-icons = [ "󰕿" "󰖀" "󰕾" ];
          format-muted = "󰝟";
          tooltip-format = "{icon} {volume}%\n󰓃 {node_name}";
          on-scroll-up = "${config.services.swayosd.package}/bin/swayosd-client --output-volume raise 5";
          on-scroll-down = "${config.services.swayosd.package}/bin/swayosd-client --output-volume lower 5";
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

      #group-quicksettings, #custom-power, #custom-reboot, #custom-lock, 
      #group-network, #network, #network.disconnected.vpn,
      #group-audio, #wireplumber, #mpris, #pulseaudio-slider,
      #group-backlight, #backlight, #backlight-slider,
      #group-clockweather, #clock, #custom-weather,
      #cpu, #memory, #disk, #temperature,
      #workspaces button, #window,
      #battery,
      #privacy, privacy-item,
      #custom-launcher,
      #custom-notification,
      #custom-darkman,
      #power-profiles-daemon,
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
          border-radius: 12px 0px 0px 0px;
          border-right: none;
      }

      #memory {
        border-radius: 0px 0px 0px 12px;
        border-top: none;
        border-right: none;
      }

      #disk {
          border-radius: 0px 12px 0px 0px;
      }

      #temperature {
          border-radius: 0px 0px 12px 0px;
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

      #network.vpn,
      #pulseaudio-slider,
      #backlight-slider {
        border-width: 0px 1px 0px 1px;
      }

      #clock,
      #custom-notification,
      #network,
      #mpris,
      #wireplumber,
      #backlight {
        border-width: 0px;
      }

      #group-quicksettings,
      #group-clockweather,
      #group-network,
      #group-audio, 
      #group-backlight {
        padding: 0;
      }

      slider {
        min-height: 0px;
        min-width: 0px;
        opacity: 0;
        background-image: none;
        border: none;
        box-shadow: none;
      }

      trough {
        min-height: 10px;
        min-width: 80px;
        border-radius: 5px;
        background-color: @theme_bg_color;
        margin: 0px 8px;
      }

      highlight {
        min-width: 10px;
        border-radius: 5px;
      }

      #pulseaudio-slider highlight,
      #backlight-slider highlight {
        background-color: @success_color;
      }
    '';
  };
}

