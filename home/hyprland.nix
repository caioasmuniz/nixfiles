{ pkgs, inputs, ... }:
let
  scratchpad = pkgs.writeScript "scratchpad" ''
    if [[ $(hyprctl workspaces -j | ${pkgs.jq}/bin/jq 'contains([{"name": "special"}])') == "false" ]];
    then
      hyprctl dispatch exec [workspace special] kitty
    else
      hyprctl dispatch togglespecialworkspace
    fi
  '';
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    systemd = { enable = true; variables = [ "--all" ]; };
    settings = {
      monitor = [
        "eDP-1,1920x1080@60,0x0,1.25"
        "DP-1,2560x1080@75,0x0,1"
      ];

      workspace = [
        "eDP-1,1"
        "DP-1,10"
      ];

      input = {
        kb_layout = "br,us";
        repeat_rate = 50;
        repeat_delay = 500;
        follow_mouse = true;
        accel_profile = "flat";
      };

      "device:DLL09D9:00 04F3:3146 Touchpad" = {
        natural_scroll = true;
        accel_profile = "adaptive";
      };

      general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 2;
        "col.active_border" = "0xffa6e3a1";
        "col.inactive_border" = "0xFF313244";
        "col.group_border" = "0xff1e1e2e";
        "col.group_border_active" = "0xffcba6f7";
        resize_on_border = true;
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
          new_optimizations = true;
        };
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 1;
      };

      animations = {
        enabled = 1;
        animation = [
          "windows,1,5,default,slide"
          "border,1,20,default"
          "fadeIn,1,5,default"
          "workspaces,1,6,default,slidevert"
        ];
      };

      misc = {
        animate_manual_resizes = true;
        vfr = true;
        vrr = 1;
        enable_swallow = true;
        swallow_regex = "kitty";
        layers_hog_keyboard_focus = true;
        focus_on_activate = true;
      };

      xwayland = { force_zero_scaling = true; };

      dwindle = {
        pseudotile = 1;
        preserve_split = true;
        no_gaps_when_only = false;
      };
      windowrulev2 = [
        "float,class:(pavucontrol)"
        "size 25% 75%,class:(pavucontrol)"
        "move 74% 5%,class:(pavucontrol)"
      ];
      bind = [
        "SUPER,W,exec,pkill -USR1 waybar"
        "SUPER,C,exec, ${pkgs.vscode}/bin/code ~/Documents/nixfiles"
        "SUPER,Return,exec,${pkgs.kitty}/bin/kitty"
        "SUPER,B,exec,firefox"
        "SUPER,V,exec,pkill pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol -t 3"
        "SUPER,E,exec,${pkgs.gnome.nautilus}/bin/nautilus"
        "SUPERSHIFT,Q,exec,pkill Hyprland"
        "SUPERSHIFT,R,exec, hyprctl reload;${pkgs.libnotify}/bin/notify-send 'Hyprland had just reloaded!'"
        ",Print,exec,${pkgs.shotman}/bin/shotman -c target"
        "SUPERCONTROL,S,exec,${pkgs.shotman}/bin/shotman -c region"

        "SUPERSHIFT,F,togglefloating,active"
        "SUPERSHIFT,G,togglegroup"
        "SUPER,G,changegroupactive,f"
        "SUPER,Q,killactive"
        "SUPER,P,exec, hyprctl dispatch pseudo"
        "SUPERSHIFT,P,exec, hyprctl --batch 'dispatch togglefloating 1;dispatch resizeactive exact 1920 1080;dispatch togglefloating 0;dispatch pseudo'"
        "SUPER,F,fullscreen"
        ",Pause,exec, ${scratchpad}"
        ",Insert,exec, ${scratchpad}"
        "SUPER,Insert,movetoworkspace,special"
        "SUPER,Pause,movetoworkspace,special"
        "SUPER,S,togglesplit"
        "SUPERSHIFT,S,swapactiveworkspaces,eDP-1 DP-1"

        ",XF86MonBrightnessUp,exec,${pkgs.brightnessctl}/bin/brightnessctl s +5%"
        ",XF86MonBrightnessDown,exec,${pkgs.brightnessctl}/bin/brightnessctl s 5%-"
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
        "bindm=SUPER,mouse:273,resizewindow"
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
      bindl = ",switch:Lid Switch,exec,systemctl suspend";
      exec = [
        "hyprctl setcursor Adwaita 24"
      ];
    };
  };
}
