{ pkgs, inputs, ... }: {
  programs = {
    waybar = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.hostPlatform.system
      }.waybar-hyprland;
      systemd = {
        enable = true;
        target = "hyprland-session.target";
      };
      settings = {
        bar = {
          layer = "top";
          position = "top";
          spacing = 4;
          modules-left = [
            "cpu"
            "memory"
            "temperature"
            "wlr/workspaces"
            # "wlr/taskbar"
            "mpris"
          ];
          modules-center = [
            "clock"
          ];
          modules-right = [
            "battery"
            "network"
            # "wireplumber"
            "pulseaudio"
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
          };
          battery = {
            bat = "BAT0";
            format-alt = "{icon}<sup> </sup>{capacity}%";
            format = "{icon}";
            format-icons = {
              charging = [ "󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" ];
              discharging = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
            };
            interval = 5;
            states = { critical = 10; warning = 25; normal = 26; good = 90; };
            tooltip = true;
            tooltip-format = " {timeTo}\n {power} W  󰂎 {capacity}%";
          };
          clock = {
            format = "{:%H:%M 󰥔<sup> </sup>󰿟󰃭 %e %b}";
            format-calendar = "<span color='#f38ba8' font='FiraCode Nerd Font'><b>{}</b></span>";
            format-calendar-weekdays = "<span color='#f38ba8'font='FiraCode Nerd Font'><b>{}</b></span>";
            interval = 1;
            on-click = "gnome-calendar &";
            today-format = "<span color='#a6e3a1'><b><u>{}</u></b></span>";
            tooltip-format = "<big><b>󰥔 {:%H:%M:%S 󰃭 %B %Y}</b></big>\n<tt><big>{calendar}</big></tt>";
          };
          cpu = {
            format = "󰻠<sup> </sup>{usage}%";
            interval = 5;
            states = { critical = 75; warning = 50; };
            tooltip-format = "{avg_frequency}";
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
                  echo ""
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
              none = "";
              dnd-none = "<sup> </sup>";
              notification = "";
              dnd-notification = "<sup> </sup>";
            };
            on-click = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
            on-click-right = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
            return-type = "json";
            tooltip = false;
          };
          "custom/weather" = {
            exec = "~/.config/waybar/modules/weather.py";
            format = "{}";
            interval = 900;
            return-type = "json";
            tooltip = true;
          };
          "hyprland/submap" = {
            format = "✌️ {}";
            max-length = 8;
            tooltip = true;
          };
          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };
          memory = {
            format = "󰍛<sup> </sup>{}%";
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
              default = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
              ethernet = "󰈀";
            };
            on-click-right = "pkill nm-connection-editor || nm-connection-editor --class='pavuctl popup' --name='pavuctl popup'";
            tooltip-format-disconnected = "Disconnected";
            tooltip-format-ethernet = " {ifname}  爵 {ipaddr}\n {bandwidthUpBytes}   {bandwidthDownBytes}";
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
            format-bluetooth = "{icon} {volume}%";
            format-muted = "󰝟";
            format-icons = {
              default = [ "󰕿" "󰖀" "󰕾" ];
              headphones = "";
              phone = "";
            };
            on-right-click = "pkill ${pkgs.pavucontrol}/bin/pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol --class='pavuctl popup' --name='pavuctl popup' -t 3";
          };
          temperature = {
            thermal-zone = 1;
            # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
            format = "{icon}<sup> </sup>{temperatureC}°C";
            format-icons = [ "" "" "" "" "" ];
            critical-threshold = 75;
          };
          tray = {
            icon-size = 20;
            show-passive-items = true;
            spacing = 4;
          };
          wireplumber = {
            format = "{icon}<sup> </sup>{volume}%";
            format-icons = [ "󰕿" "󰖀" "󰕾" ];
            format-muted = "󰝟";
            on-scroll-up = "${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 1%+";
            on-scroll-down = "${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 1%-";
            on-click = "pkill ${pkgs.pavucontrol}/bin/pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol --class='pavuctl popup' --name='pavuctl popup' -t 3";
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
            format-icons = {
              active = "";
              default = "";
              urgent = "";
            };
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

          /* border: 2px solid #abe9b3; */
        }

        #battery,
        #backlight,
        #clock,
        #cpu,
        #taskbar,
        #custom-weather,
        #memory,
        #pulseaudio,
        #wireplumber,
        #workspaces button,
        #network,
        #network.disconnected.vpn,
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
          margin-top: 4px;
          margin-bottom: 0px;
          background-color: @theme_bg_color;
          color: @theme_text_color;
          font-weight: bold;
          min-height: 24px;
        }

        #cpu {
          margin-left: 4px;
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
        #taskbar button.active,
        #workspaces button.active {
          background-color: @success_color;
          color: @theme_bg_color;
        }

        #custom-notification {
          margin-right: 4px;
        }

        #taskbar {
          padding: 0px;
        }

        #taskbar button {
          padding: 0px 4px;
          transition: all 0.3s cubic-bezier(0.55, -0.68, 0.48, 1.682);
        }

        #taskbar button.active {
          border-radius: 11px;
        }

        #taskbar button:hover {
          border-radius: 11px;
          background-color: @theme_selected_bg_color;
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
  };
}

