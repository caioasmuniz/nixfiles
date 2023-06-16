{ pkgs, ... }:
let
  scratchpad = pkgs.writeScript "scratchpad" ''
    if [[ $(hyprctl workspaces -j |${pkgs.jq}/bin/jq '.[-1]|.id') != "-99" ]];
    then
      hyprctl dispatch exec [workspace special:scratchpad] kitty
      sleep 1
    fi
      hyprctl dispatch togglespecialworkspace scratchpad
  '';
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    extraConfig = ''
      monitor=eDP-1,1920x1080@60,2560x0,1.25
      monitor=DP-1,2560x1080@75,0x0,1

      workspace=eDP-1,1
      workspace=DP-1,10

      input {
          kb_layout=br,us
          kb_variant=
          kb_model=
          kb_options=
          kb_rules=
          repeat_rate=50
          repeat_delay=500

          follow_mouse=true
          accel_profile=flat

          # sensitivity=0.0
          touchpad {
          }
      }

      device:DLL09D9:00 04F3:3146 Touchpad {
          	accel_profile=adaptive
              natural_scroll=true
      }

      general {
          # main_mod=SUPER

          gaps_in=2
          gaps_out=4
          border_size=2
          col.active_border=0xffa6e3a1
          col.inactive_border=0xFF313244
          col.group_border=0xff1e1e2e
          col.group_border_active=0xffcba6f7
          resize_on_border=true
      }

      gestures {
          workspace_swipe=true
          workspace_swipe_fingers=3
          workspace_swipe_create_new=true
      }

      decoration {
          rounding=12
          blur=1
          blur_size=5
          blur_passes=2
          blur_new_optimizations=true
          drop_shadow=true
          shadow_range=4
          shadow_render_power=1
          # screen_shader=~/.config/hypr/shader.frag
      }

      bezier=overshot,0.05,0.9,0.1,1.1

      animations {
          enabled=1
          animation=windows,1,5,default,slide
          animation=border,1,20,default
          animation=fadeIn,1,5,default
          animation=workspaces,1,6,default,slidevert
      }
      misc {
          animate_manual_resizes=true
          vfr=true
          vrr=1
          enable_swallow=true
          swallow_regex=kitty
          layers_hog_keyboard_focus=true
          focus_on_activate=true
      }

      dwindle {
          pseudotile=1 # enable pseudotiling on dwindle
          preserve_split=true
          no_gaps_when_only=false
      }

      windowrulev2=float,class:^(pavuctl popup)$
      windowrulev2=size 25% 75%,class:^(pavuctl popup)$
      windowrulev2=move 74% 5%,class:^(pavuctl popup)$
      
      windowrulev2=float, class:^(swaync)$
      windowrulev2=move 100%-512 42, class:^(swaync)$
      windowrulev2=animation slide, class:^(swaync)$

      windowrulev2=float,class:^(com.nextcloud.desktopclient.nextcloud)$
      windowrulev2=size 25% 75%,class:^(com.nextcloud.desktopclient.nextcloud)$
      windowrulev2=move 74% 4%,class:^(com.nextcloud.desktopclient.nextcloud)$

      windowrulev2=float,class:^(wofi)$
      windowrulev2=animation popin ,class:^(wofi)$

      # blurls=gtk-layer-shell

      bind=SUPER,W,exec,pkill -USR1 waybar
      bind=SUPER,C,exec, ${pkgs.vscode}/bin/code ~/Documents/nixfiles
      bind=SUPER,Return,exec,${pkgs.kitty}/bin/kitty
      bind=SUPER,B,exec,firefox
      bind=SUPER,V,exec,${pkgs.pavucontrol}/bin/pavucontrol
      bind=SUPER,E,exec,${pkgs.gnome.nautilus}/bin/nautilus
      bind=SUPERSHIFT,Q,exec,pkill Hyprland
      bind=SUPERSHIFT,R,exec, hyprctl reload;${pkgs.libnotify}/bin/notify-send "Hyprland had just reloaded!"
      bind=,Print,exec,${pkgs.shotman}/bin/shotman -c target
      bind=SUPERCONTROL,S,exec,${pkgs.shotman}/bin/shotman -c region

      bind=SUPERSHIFT,F,togglefloating,active
      bind=SUPERSHIFT,G,togglegroup
      bind=SUPER,G,changegroupactive,f
      bind=SUPER,Q,killactive
      bind=SUPER,P,exec, hyprctl dispatch pseudo
      bind=SUPERSHIFT,P,exec, hyprctl --batch "dispatch togglefloating 1;dispatch resizeactive exact 1920 1080;dispatch togglefloating 0;dispatch pseudo"
      bind=SUPER,F,fullscreen
      bind=,Pause,exec, ${scratchpad}
      bind=,Insert,exec, ${scratchpad}
      bind=SUPER,Insert,movetoworkspace,special:scratchpad
      bind=SUPER,Pause,movetoworkspace,special:scratchpad
      bind=SUPER,S,togglesplit
      bind=SUPERSHIFT,S,swapactiveworkspaces,eDP-1 DP-1

      # bind=,XF86AudioRaiseVolume,exec,wpctl set-volume -l "1.0" @DEFAULT_AUDIO_SINK@ 5%+
      # bind=,XF86AudioLowerVolume,exec,wpctl set-volume -l "1.0" @DEFAULT_AUDIO_SINK@ 5%-
      # bind=,XF86AudioMute,exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bind=,XF86MonBrightnessUp,exec,${pkgs.brightnessctl}/bin/brightnessctl s +5%
      bind=,XF86MonBrightnessDown,exec,${pkgs.brightnessctl}/bin/brightnessctl s 5%-
      bind=,XF86AudioMedia,exec,${pkgs.playerctl}/bin/playerctl play-pause
      bind=,XF86AudioPlay,exec,${pkgs.playerctl}/bin/playerctl play-pause
      bind=,XF86AudioStop,exec,${pkgs.playerctl}/bin/playerctl stop
      bind=,XF86AudioPrev,exec,${pkgs.playerctl}/bin/playerctl previous
      bind=,XF86AudioNext,exec,${pkgs.playerctl}/bin/playerctl next

      bindm=SUPER,mouse:272,movewindow
      bindm=SUPER,mouse:273,resizewindow

      bind=SUPER,left,movefocus,l
      bind=SUPER,right,movefocus,r
      bind=SUPER,up,movefocus,u
      bind=SUPER,down,movefocus,d
      bind=SUPERSHIFT,left,movewindow,l
      bind=SUPERSHIFT,right,movewindow,r
      bind=SUPERSHIFT,up,movewindow,u
      bind=SUPERSHIFT,down,movewindow,d
      binde=SUPERCONTROL,left,resizeactive,-64 0
      binde=SUPERCONTROL,right,resizeactive,64 0
      binde=SUPERCONTROL,up,resizeactive,0 -64
      binde=SUPERCONTROL,down,resizeactive,0 64
      bind=SUPERALT,up,workspace,-1
      bind=SUPERALT,down,workspace,+1
      bind=SUPERSHIFTALT,left,movewindow,mon:-1
      bind=SUPERSHIFTALT,right,movewindow,mon:+1
      bind=SUPERSHIFTALT,up,movetoworkspace,-1
      bind=SUPERSHIFTALT,down,movetoworkspace,+1

      bind=SUPER,j,movefocus,l
      bind=SUPER,l,movefocus,r
      bind=SUPER,i,movefocus,u
      bind=SUPER,k,movefocus,d
      bind=SUPERSHIFT,j,movewindow,l
      bind=SUPERSHIFT,l,movewindow,r
      bind=SUPERSHIFT,i,movewindow,u
      bind=SUPERSHIFT,k,movewindow,d
      binde=SUPERCONTROL,j,resizeactive,-64 0
      binde=SUPERCONTROL,l,resizeactive,64 0
      binde=SUPERCONTROL,i,resizeactive,0 -64
      binde=SUPERCONTROL,k,resizeactive,0 64
      bind=SUPERALT,i,workspace,-1
      bind=SUPERALT,k,workspace,+1
      bind=SUPERSHIFTALT,i,movetoworkspace,-1
      bind=SUPERSHIFTALT,k,movetoworkspace,+1

      bindl=,switch:Lid Switch,exec,systemctl suspend

      # exec-once=${pkgs.dbus}/bin/dbus-update-activation-environment --all
      exec=${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/font-name '"Fira Sans Regular 10"'
      exec=${pkgs.dconf}/bin/dconf write /org/gnome/desktop/wm/preferences/button-layout '":"'
 
      exec=hyprctl setcursor Adwaita 24
      exec-once=${pkgs.wlsunset}/bin/wlsunset -l -23.1 -L -50.6 -t 4000 -T 6500 &
      exec-once=kdeconnect-indicator &
      exec-once = sleep 10 && nextcloud --background &
    '';
  };
}
