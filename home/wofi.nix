{ pkgs, ... }: {
  programs.wofi = {
    enable = true;
    settings = {
      width = 300;
      height = 500;
      image_size = 40;
      location = "top_left";
      xoffset = 12;
      yoffset = 12;
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
    };

    style = ''
        window {
      	border-radius: 12px;
        border: 1px solid @success_color;
      	background: alpha(@theme_bg_color, 0.75);
      }

      #input {
      	border-radius: 12px;
      	margin: 4px;
      }

      #scroll { 
      	padding: 4px;
      }

      .entry {
      	padding: 4px;
      }

      #img {
      	padding-right: 8px;	
      }

      #entry:selected {
      	border-radius: 12px;
      } 
    '';
  };
  wayland.windowManager.hyprland.extraConfig = ''
    bind=SUPER,Space,exec, pkill wofi || ${pkgs.wofi}/bin/wofi
    layerrule=blur,wofi
    '';
}
