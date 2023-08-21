{ pkgs, ... }: {
  programs.wofi = {
    enable = true;
    settings = {
      width = 300;
      height = 500;
      image_size = 40;
      location = "center";
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
    bind=SUPER,Space,exec, pkill wofi || ${pkgs.wofi}/bin/wofi -n -s ~/.config/wofi/style.css
    windowrulev2 = float,class:(wofi)
    windowrulev2 = move 12 42,class:(wofi)
    windowrulev2 = animation slide ,class:(wofi)
  '';
}
