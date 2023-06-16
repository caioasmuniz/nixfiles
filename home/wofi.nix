{ pkgs, ... }: {
  home.packages = [ pkgs.wofi ];
  wayland.windowManager.hyprland.extraConfig = ''
    bind=SUPER,Space,exec, ${pkgs.wofi}/bin/wofi -n -s ~/.config/wofi/style.css
  '';
  xdg.configFile = {
    "wofi/config".text = ''
      width=300
      height=500
      image_size=40
      location=center
      show=drun
      prompt=Search...
      filter_rate=100
      allow_markup=true
      no_actions=true
      halign=fill
      orientation=vertical
      content_halign=fill
      insensitive=true
      allow_images=true
    '';

    "wofi/style.css".text = ''
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
}
