{
  pkgs,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [ pkgs.hyprlandPlugins.hypr-dynamic-cursors ];
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    extraConfig = ''
      device {
        name=DLL09D9:00 04F3:3146 Touchpad
        accel_profile=adaptive
      }'';
    settings = {
      monitor = [
        "eDP-1,1920x1080@60,2560x216,1.25"
        "desc:LG Electronics LG HDR WFHD 0x0003187E,2560x1080@75,0x0,1"
      ];

      workspace = [
        "special:scratchpad, on-created-empty: [pseudo; size 1920 1080] ghostty"
        "1, monitor:eDP-1, default:true"
        "10, monitor:HDMI-A-1, default:true"
      ];

      input = {
        kb_layout = "br,us";
        repeat_rate = 50;
        repeat_delay = 500;
        follow_mouse = true;
        accel_profile = "flat";
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.5;
        };
      };

      general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 2;
        "col.active_border" = "0xffa6e3a1";
        "col.inactive_border" = "0xFF313244";
        resize_on_border = true;
      };

      group = {
        "col.border_active" = "0xff1e1e2e";
        "col.border_inactive" = "0xffcba6f7";
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_create_new = true;
      };

      decoration = {
        rounding = 12;
        blur = {
          enabled = true;
          passes = 2;
          special = true;
          popups = true;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 4;
        };
      };

      animations = {
        enabled = 1;
        animation = [
          "windows,1,5,default,slide"
          "layers,1,5,default,slide"
          "border,1,20,default"
          "borderangle,1,45,default,once"
          "fadeIn,1,5,default"
          "workspaces,1,6,default,slidevert"
        ];
      };

      misc = {
        animate_manual_resizes = true;
        animate_mouse_windowdragging = false;
        vfr = true;
        vrr = 1;
        enable_swallow = true;
        swallow_regex = "kitty";
        layers_hog_keyboard_focus = true;
        focus_on_activate = true;
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      dwindle = {
        pseudotile = 1;
        preserve_split = true;
      };

      plugin = {
        dynamic-cursors = {
        enabled = true;
        mode = "none";
        shake = {
          enabled = true;
          threshold = 3.0;
          timeout = 1000;
          limit = 4.0;
          speed = 0.0;
        };
        hyprcursor = {
          enabled = true;
          nearest = false;
          fallback = "default";
          };
        };
      };

      layerrule = [
        "noanim,selection"
      ];
      windowrulev2 = [
        "float,class:(pwvucontrol)"
        "size 900 900,class:(pwvucontrol)"
        "move 100%-912 64,class:(pwvucontrol)"
        "pseudo,tag:16x9"
        "size 1920 1080,tag:16x9"
      ];
      bind = [
        "SUPER,C,exec, ${lib.getExe pkgs.vscode} ~/Documents/nixfiles/nixfiles.code-workspace"
        "SUPER,Return,exec,${lib.getExe pkgs.ghostty}"
        "SUPER,B,exec,firefox"
        "SUPER,V,exec,pkill pwvucontrol || pwvucontrol"
        "SUPER,E,exec,nautilus"
        "SUPERSHIFT,v,exec,pkill wvkbd || ${lib.getExe pkgs.wvkbd}"

        "SUPER, PRINT, exec, ${lib.getExe pkgs.hyprshot} -m window"
        ", PRINT, exec, ${lib.getExe pkgs.hyprshot} -m output"
        "SUPERSHIFT, PRINT, exec, ${lib.getExe pkgs.hyprshot} -m region"

        "SUPERSHIFT,R,exec, hyprctl reload;${pkgs.libnotify}/bin/notify-send 'Hyprland had just reloaded!'"
        "SUPERSHIFT,Q,exec,pkill Hyprland"

        "SUPERSHIFT,F,togglefloating,active"
        "SUPERSHIFT,G,togglegroup"
        "SUPER,G,changegroupactive,f"
        "SUPER,Q,killactive"
        "SUPER,P,exec, hyprctl dispatch pseudo"
        "SUPERSHIFT,P,exec, hyprctl --batch 'dispatch togglefloating 1;dispatch resizeactive exact 1920 1080;dispatch togglefloating 0;dispatch pseudo'"
        "SUPER,F,fullscreen"
        ",Pause,togglespecialworkspace, scratchpad"
        ",Insert,togglespecialworkspace,scratchpad"
        "SUPER,Insert,movetoworkspace,special:scratchpad"
        "SUPER,Pause,movetoworkspace,special:scratchpad"
        "SUPER,S,togglesplit"
        "SUPERSHIFT,S,swapactiveworkspaces,eDP-1 DP-1"

        ",XF86AudioMedia,exec,${pkgs.playerctl}/bin/playerctl play-pause"
        ",XF86AudioPlay,exec,${pkgs.playerctl}/bin/playerctl play-pause"
        ",XF86AudioStop,exec,${pkgs.playerctl}/bin/playerctl stop"
        ",XF86AudioPrev,exec,${pkgs.playerctl}/bin/playerctl previous"
        ",XF86AudioNext,exec,${pkgs.playerctl}/bin/playerctl next"

        "SUPER,left,movefocus,l"
        "SUPER,right,movefocus,r"
        "SUPER,up,movefocus,u"
        "SUPER,down,movefocus,d"
        "SUPERSHIFT,left,movewindow,l"
        "SUPERSHIFT,right,movewindow,r"
        "SUPERSHIFT,up,movewindow,u"
        "SUPERSHIFT,down,movewindow,d"
        "SUPERALT,up,workspace,-1"
        "SUPERALT,down,workspace,+1"
        "SUPERSHIFTALT,left,movewindow,mon:-1"
        "SUPERSHIFTALT,right,movewindow,mon:+1"
        "SUPERSHIFTALT,up,movetoworkspace,-1"
        "SUPERSHIFTALT,down,movetoworkspace,+1"

        "SUPER,j,movefocus,l"
        "SUPER,l,movefocus,r"
        "SUPER,i,movefocus,u"
        "SUPER,k,movefocus,d"
        "SUPERSHIFT,j,movewindow,l"
        "SUPERSHIFT,l,movewindow,r"
        "SUPERSHIFT,i,movewindow,u"
        "SUPERSHIFT,k,movewindow,d"
        "SUPERALT,i,workspace,-1"
        "SUPERALT,k,workspace,+1"
        "SUPERSHIFTALT,i,movetoworkspace,-1"
        "SUPERSHIFTALT,k,movetoworkspace,+1"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      bindle = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%-"
        "SHIFT, XF86AudioRaiseVolume, exec, swayosd-client --input-volume raise 5"
        "SHIFT, XF86AudioLowerVolume, exec, swayosd-client --input-volume lower 5"
      ];

      bindm = [
        "SUPER,mouse:272,movewindow"
        "SUPER,SHIFT, movewindow"
        "SUPER,mouse:273,resizewindow"
        "SUPER,CONTROL,resizewindow"
      ];

      binde = [
        "SUPERCONTROL,left,resizeactive,-64 0"
        "SUPERCONTROL,right,resizeactive,64 0"
        "SUPERCONTROL,up,resizeactive,0 -64"
        "SUPERCONTROL,down,resizeactive,0 64"
        "SUPERCONTROL,j,resizeactive,-64 0"
        "SUPERCONTROL,l,resizeactive,64 0"
        "SUPERCONTROL,i,resizeactive,0 -64"
        "SUPERCONTROL,k,resizeactive,0 64"
        ",XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ",XF86MonBrightnessDown, exec, brightnessctl set -5%"
      ];
      exec = [ "hyprctl setcursor Adwaita 24" ];
    };
  };
}
