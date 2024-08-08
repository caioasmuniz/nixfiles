{ pkgs, lib, inputs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    systemd = { enable = true; variables = [ "--all" ]; };
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
        "special:scratchpad, on-created-empty: kitty"
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
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 1;
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

      xwayland = { force_zero_scaling = true; };

      dwindle = {
        pseudotile = 1;
        preserve_split = true;
        no_gaps_when_only = false;
      };
      windowrulev2 = [
        "float,class:(pwvucontrol)"
        "size 450 900,class:(pwvucontrol)"
        "move 100%-462 50%-450,class:(pwvucontrol)"
      ];
      bind = [
        "SUPER,W,exec,pkill -USR1 waybar"
        "SUPER,C,exec, ${pkgs.vscode}/bin/code ~/Documents/nixfiles"
        "SUPER,Return,exec,${pkgs.kitty}/bin/kitty"
        "SUPER,B,exec,firefox"
        "SUPER,V,exec,pkill pwvucontrol || pwvucontrol"
        "SUPER,E,exec,nautilus"
        "SUPERSHIFT,Q,exec,pkill Hyprland"
        "SUPERSHIFT,R,exec, hyprctl reload;${pkgs.libnotify}/bin/notify-send 'Hyprland had just reloaded!'"
        "SUPER, PRINT, exec, ${pkgs.hyprshot} -m window"
        ", PRINT, exec, ${pkgs.hyprshot} -m output"
        "SUPERSHIFT, PRINT, exec, ${pkgs.hyprshot} -m region"
        "SUPERSHIFT,v,exec,pkill wvkbd || ${lib.getExe pkgs.wvkbd}"

        "SUPERSHIFT,F,togglefloating,active"
        "SUPERSHIFT,G,togglegroup"
        "SUPER,G,changegroupactive,f"
        "SUPER,Q,killactive"
        "SUPER,P,exec, hyprctl dispatch pseudo"
        "SUPERSHIFT,P,exec, hyprctl --batch 'dispatch togglefloating 1;dispatch resizeactive exact 1920 1080;dispatch togglefloating 0;dispatch pseudo'"
        "SUPER,F,fullscreen"
        ",Pause,togglespecialworkspace, scratchpad"
        ",Insert,togglespecialworkspace,scratchpad"
        "SUPER,Insert,movetoworkspace,special"
        "SUPER,Pause,movetoworkspace,special"
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
      ];

      bindm = [
        "SUPER,mouse:272,movewindow"
        "SUPER,mouse:273,resizewindow"
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
      ];
      exec = [ "hyprctl setcursor Adwaita 24" ];
    };
  };
}
