{ pkgs, ... }: {
  home.packages = [ pkgs.swaynotificationcenter ];
  systemd.user.services.swaync = {
    Unit = {
      Description = "Swaync notification daemon";
      Documentation = "https://github.com/ErikReider/SwayNotificationCenter";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };
    Service = {
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
      ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
      ExecReload = "${pkgs.swaynotificationcenter}/bin/swaync-client --reload-config;${pkgs.swaynotificationcenter}/bin/swaync-client --reload-css";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "hyprland-session.target" ];
  };

  xdg.configFile."swaync/config.json".text = ''
    {
      "$schema": "/etc/xdg/swaync/configSchema.json",
      "positionX": "right",
      "positionY": "top",
      "layer-shell": false,
      "control-center-margin-top": 0,
      "control-center-margin-bottom": 0,
      "control-center-margin-right": 0,
      "control-center-margin-left": 0,
      "notification-icon-size": 64,
      "notification-body-image-height": 100,
      "notification-body-image-width": 200,
      "timeout": 10,
      "timeout-low": 5,
      "timeout-critical": 0,
      "fit-to-screen": true,
      "control-center-width": 500,
      "control-center-height": 1000,
      "notification-window-width": 350,
      "keyboard-shortcuts": true,
      "image-visibility": "when-available",
      "transition-time": 200,
      "hide-on-clear": false,
      "hide-on-action": true,
      "widgets": [
        "title",
        "dnd",
        "menubar",
        "buttons-grid",
        "volume",
        "backlight",
        "mpris",
        "notifications"
      ],
      "widget-config": {
        "title": {
          "text": "Notifications",
          "clear-all-button": true,
          "button-text": "Clear All"
        },
        "dnd": {
          "text": "Do Not Disturb"
        },
        "mpris": {
          "image-size": 128,
          "image-radius": 12
        },
        "backlight": {
          "label": "󰃠"
        },
        "volume": {
          "label": "",
          "show-per-app": true,
          "expand-button-label": "",
          "collapse-button-label": ""
        },
        "menubar": {
          "menu#power": {
            "label": "",
            "position": "center",
            "actions": [
              {
                "label": " Lock",
                "command": "gtklock"
              },
              {
                "label": "󰗽 Logout",
                "command": "hyprctl kill"
              },
              {
                "label": " Suspend",
                "command": "systemctl suspend"
              },
              {
                "label": " Reboot",
                "command": "systemctl reboot"
              },
              {
                "label": " Shutdown",
                "command": "systemctl poweroff"
              }
            ]
          },
          "menu#powermode-buttons": {
            "label": "󰓅",
            "position": "center",
            "actions": [
              {
                "label": "󰓅 Performance",
                "command": "powerprofilesctl set performance"
              },
              {
                "label": "󰗑 Balanced",
                "command": "powerprofilesctl set balanced"
              },
              {
                "label": " Power-saver",
                "command": "powerprofilesctl set power-saver"
              }
            ]
          },
          "menu#screenshot-buttons": {
            "label": "",
            "position": "center",
            "actions": [
              {
                "label": "   Entire screen",
                "command": "swaync-client -cp && sleep 1 && hyprshot -m output"
              },
              {
                "label": "   Select a region",
                "command": "swaync-client -cp && sleep 1 && hyprshot -m region"
              },
              {
                "label": "   Open screenshot folder",
                "command": "exo-open $HYPRSHOT_DIR"
              }
            ]
          }
        },
        "buttons-grid": {
          "actions": [
            {
              "label": "",
              "command": "pactl set-sink-mute @DEFAULT_SINK@ toggle"
            },
            {
              "label": "",
              "command": "pactl set-source-mute @DEFAULT_SOURCE@ toggle"
            },
            {
              "label": "",
              "command": "iwgtk"
            },
            {
              "label": "/",
              "command": "darkman toggle"
            }
          ]
        }
      }
    }
  '';
  xdg.configFile."swaync/style.css".text = ''
    .notification-row {
      outline: none;
      padding: 0;
      margin: 0;
    }

    .notification-row:focus,
    .notification-row:hover {
      background: transparent;
    }

    .notification {
      border-radius: 12px;
      margin: 0;
      padding: 0;
      box-shadow: none;

    }

    /* Uncomment to enable specific urgency colors
    .low {
      background: yellow;
      padding: 6px;
      border-radius: 12px;
    }

    .normal {
      background: green;
      padding: 6px;
      border-radius: 12px;
    }

    .critical {
      background: red;
      padding: 6px;
      border-radius: 12px;
    }
    */

    .notification-content {
      background: transparent;
      padding: 4px;
      border-radius: 12px;
    }

    .close-button {
      background: @theme_unfocused_bg_color;
      color: @theme_unfocused_fg_color;
      text-shadow: none;
      padding: 0;
      border-radius: 100%;
      margin: 6px 12px 4px 4px;
      box-shadow: none;
      border: none;
      min-width: 24px;
      min-height: 24px;
    }

    .close-button:hover {
      box-shadow: none;
      background: @error_color;
      color: @theme_bg_color;
      transition: all 0.15s ease-in-out;
      border: none;
    }

    .notification-default-action,
    .notification-action {
      padding: 4px;
      margin: 0;
      box-shadow: none;
      background: @theme_bg_color;
      border: 1px solid @noti-border-color;
      color: @theme_text_color;
    }

    .notification-row:focus .notification-default-action,
    .notification-default-action:hover,
    .notification-action:hover {
      -gtk-icon-effect: none;
      background: @theme_base_color;
    }

    .notification-default-action {
      border-radius: 12px;
    }
    /* When alternative actions are visible */
    .notification-default-action:not(:only-child) {
      border-bottom-left-radius: 0px;
      border-bottom-right-radius: 0px;
    }

    .notification-action {
      border-radius: 0px;
      border-top: none;
      border-right: none;
    }

    /* add bottom border radius to eliminate clipping */
    .notification-action:first-child {
      border-bottom-left-radius: 12px;
    }

    .notification-action:last-child {
      border-bottom-right-radius: 12px;
      border-right: 1px solid @noti-border-color;
    }

    .image {
    }

    .body-image {
      margin-top: 6px;
      background-color: @theme_text_color;
      border-radius: 12px;
    }

    .summary {
      font-size: 16px;
      font-weight: bold;
      background: transparent;
      color: @theme_text_color;
      text-shadow: none;
    }

    .time {
      font-size: 16px;
      font-weight: bold;
      background: transparent;
      color: @theme_text_color;
      text-shadow: none;
      margin-right: 18px;
    }

    .body {
      font-size: 15px;
      font-weight: normal;
      background: transparent;
      color: @theme_text_color;
      text-shadow: none;
    }

    /* The "Notifications" and "Do Not Disturb" text widget */
    .top-action-title {
      color: @theme_text_color;
      text-shadow: none;
    }

    .control-center {
      background: transparent;
    }

    .control-center-list {
      background: transparent;
      margin: 0;
      padding: 4px;
    }

    .floating-notifications {
      background: transparent;
      margin: 0;
      padding: 0;
    }

    /* Window behind control center and on all other monitors */
    .blank-window {
      background: transparent;
    }

    /*** Widgets ***/

    /* Title widget */
    .widget-title {
      margin: 4px 4px 0px 4px;
      padding: 8px;
      /* background: @theme_bg_color; */
      background: @theme_bg_color;
      border-radius: 12px 12px 0px 0px;
      border: 1px solid @noti-border-color;
      border-bottom: none;
      font-size: 1.5rem;
    }
    .widget-title > button {
      font-size: initial;
      color: @theme_text_color;
      text-shadow: none;
      background: @theme_bg_color;
      border: 1px solid @noti-border-color;
      box-shadow: none;
      border-radius: 12px;
    }
    .widget-title > button:hover {
      background: @theme_bg_color-hover;
    }

    /* DND widget */
    .widget-dnd {
      margin: 0px 4px 2px 4px;
      padding: 8px;
      background: @theme_bg_color;
      border-radius: 0px 0px 12px 12px;
      border: 1px solid @noti-border-color;
      border-top: none;
      font-size: 1.1rem;
    }

    .widget-dnd > switch {
      font-size: initial;
      border-radius: 12px;
      background: @theme_bg_color;
      border: 1px solid @noti-border-color;
      box-shadow: none;
    }
    .widget-dnd > switch:checked {
      background: @theme_selected_bg_color;
    }
    .widget-dnd > switch slider {
      background: @theme_bg_color-hover;
      border-radius: 12px;
    }

    /* Label widget */
    .widget-label {
      margin: 8px;
    }
    .widget-label > label {
      font-size: 1.1rem;
    }

    /* Mpris widget */
    .widget-mpris {
      margin: 2px 4px;
      background: @theme_bg_color;
      border-radius: 12px;
      border: 1px solid @noti-border-color;
    }

    /* The parent to all players */
    .widget-mpris-player {
      padding: 0px;
      margin: 8px;
    }
    .widget-mpris-title {
      font-weight: bold;
      font-size: 1.25rem;
    }
    .widget-mpris-subtitle {
      font-size: 1.1rem;
    }
    .widget-volume,
    .widget-backlight {
      font-size: 20px;
      margin: 2px 4px;
      background: @theme_bg_color;
      border-radius: 12px;
      border: 1px solid @noti-border-color;
    }
    .widget-menubar {
      font-size: 20px;
      margin: 2px 4px;
      background: @theme_bg_color;
      border-radius: 12px;
      border: 1px solid @noti-border-color;
    }
    .widget-buttons-grid {
      font-size: 20px;
      margin: 2px 4px;
      background: @theme_bg_color;
      border-radius: 12px;
      border: 1px solid @noti-border-color;
    }
  '';
}
