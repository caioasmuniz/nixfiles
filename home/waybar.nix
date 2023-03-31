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
            format = "{icon} {percent}%";
            format-icons = [ "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨" ];
            on-scroll-down = "brightnessctl s 5%-";
            on-scroll-up = "brightnessctl s +5%";
            tooltip = true;
          };
          battery = {
            bat = "BAT0";
            format = "{icon} {capacity}%";
            format-discharging = "{icon} {capacity}%";
            format-icons = [ "" "" "" "" "" "" "" "" "" "" "" ];
            interval = 5;
            states = { critical = 15; good = 100; normal = 99; warning = 30; };
            tooltip = true;
            tooltip-format = " {timeTo}\n {power} W";
          };
          clock = {
            format = "{:%H:%M 󰥔<b></b> 󰃭 %e %b}";
            format-calendar = "<span color='#b4befe' font='FiraCode Nerd Font'><b>{}</b></span>";
            format-calendar-weekdays = "<span color='#f38ba8'font='FiraCode Nerd Font'><b>{}</b></span>";
            interval = 1;
            on-click = "gnome-calendar &";
            today-format = "<span color='#a6e3a1'><b><u>{}</u></b></span>";
            tooltip-format = "<big><b>  {:%H:%M:%S     %B %Y}</b></big>\n<tt><big>{calendar}</big></tt>";
          };
          cpu = {
            format = " {usage}%";
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
            format = " {}%";
            interval = 5;
            on-click = "kitty btop &";
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
            format = "{icon} {signalStrength}%";
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
              if [[ $(nmcli device status | grep wg0 | grep connected) == "" ]]
              then
              nmcli connection up wg0
              else
              nmcli connection down wg0
              fi'';
          };
          pulseaudio = {
            format = "{icon} {volume}%";
            format-bluetooth = "{icon} {volume}%";
            format-muted = "󰝟";
            format-icons = {
              default = [ "󰕿" "󰖀" "󰕾" ];
              headphones = "";
              phone = "";
            };
            on-click = "pkill pavucontrol || pavucontrol --class='pavuctl popup' --name='pavuctl popup' -t 3";
          };
          tray = {
            icon-size = 20;
            show-passive-items = true;
            spacing = 5;
          };
          wireplumber = {
            format = "{icon} {volume}%";
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
        @keyframes blink-warning {
          from {
            color: @warning_color;
            background-color: @theme_base_color;
            border: 1px solid @warning_color;
          }

          to {
            color: @theme_base_color;
            background-color: @warning_color;
            border: 1px solid @borders;
          }
        }

        @keyframes blink-critical {
          from {
            color: @error_color;
            background-color: @theme_base_color;
            border: 1px solid @error_color;
          }

          to {
            color: @theme_base_color;
            background-color: @error_color;
            border: 1px solid @borders;
          }
        }
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

        /* #custom-ddcutil, */
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
        #custom-notification,
        #custom-darkman,
        #custom-powerprofiles,
        #mpris,
        #idle_inhibitor,
        #tray {
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
        
        #battery {
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
          margin-right: 0px;
        }

        #battery.good {
          background-color: @success_color;
          color: @theme_base_color;
        }

        #battery.warning.discharging {
          animation-name: blink-warning;
          animation-duration: 3s;
        }

        #battery.critical.discharging {
          animation-name: blink-critical;
          animation-duration: 2s;
        }

        #clock {
          font-weight: bold;
        }

        #cpu {
          margin-left: 4px;
          color: @theme_base_color;
          background-color: @success_color;
        }

        #cpu.warning {
          background-color: @warning_color;
        }

        #cpu.critical {
          background-color: @error_color;
        }

        #memory {
          color: @theme_base_color;
          background-color: @success_color;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }

        #memory.warning {
          background-color: @warning_color;
        }

        #memory.critical {
          background-color: @error_color;
        }

        #network.vpn {
          background-color: @success_color;
          color: @theme_base_color;
        }

        #network.disconnected {
          background-color: @theme_bg_color;
          color: @theme_text_color;
        }

        #wireplumber.muted,
        #pulseaudio.muted {
          background-color: @error_color;
          color: @theme_bg_color;
        }

        #temperature.critical {
          background-color: @error_color;
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
          background-color: @success_color;
          transition: all 0.5s cubic-bezier(0.55, -0.68, 0.48, 1.68);
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
          padding: 0px 5px;
          color: @theme_unfocused_fg_color;
          transition: all 0.5s cubic-bezier(0.55, -0.68, 0.48, 1.68);
          margin-right: 4px;
        }

        #workspaces button.active {
          background-color: @success_color;
          color: @theme_base_color;
          transition: all 0.3s cubic-bezier(0.55, -0.68, 0.48, 1.682);
        }

        #workspaces button.urgent {
          color: @theme_base_color;
          background-color: @warning_color;
          border-radius: 12px;
        }

        #workspaces button:hover {
          color: @success_color;
          border-radius: 12px;
        }
      '';
    };
  };
}

