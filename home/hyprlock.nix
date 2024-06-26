{ ... }: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 300;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [{
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;
      }];

      input-field = [{
        size = "200, 50";
        position = "0, -80";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        outline_thickness = 5;
        placeholder_text = ''Password...'';
        shadow_passes = 2;
      }];

      label = [{
        monitor = "";
        text = "$TIME";
        font_size = 50;
        position = "0, 80";
        valign = "center";
        halign = "center";
      }];
    };
  };
}
