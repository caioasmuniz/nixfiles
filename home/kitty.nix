{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    font = {
      size = 10;
      package = [ (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; }) ];
    };
    settings = {
      cursor_shape = "beam";
      cursor_beam_thickness = 1.5;
      cursor_blink_interval = 1;
      cursor_stop_blinking_after = 0;

      mouse_hide_wait = 3.0;
      focus_follows_mouse = "yes";

      detect_urls = "yes";
      url_style = "straight";

      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = "yes";
      resize_draw_strategy = "size";

      draw_minimal_borders = "yes";
      window_border_width = "0.5pt";
      window_padding_width = 0.5;
      window_margin_width = 0;

      tab_bar_edge = "bottom";
      tab_bar_margin_width = 0.0;
      tab_bar_style = "powerline";
      tab_bar_align = "left";
      tab_bar_min_tabs = 2;
      tab_powerline_style = "round";
      tab_activity_symbol = "none";
      tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}";
      active_tab_title_template = "none";

      background_opacity = 0.75;
      dynamic_background_opacity = "yes";

      allow_remote_control = "yes";
      shell_integration = "enabled";
      linux_display_server = "wayland";
    };
  };
  xdg.configFile."kitty/themes/adwaita.conf".text = ''
    selection_background #000000
    selection_foreground #FFFFFF
    background #FFFFFF
    foreground #171421
    cursor #000000
    color0 #171421
    color8 #5E5C64
    color1 #C01C28
    color9 #F66151
    color2 #26A269
    color10 #33D17A
    color3 #A2734C
    color11 #E9AD0C
    color4 #12488B
    color12 #2A7BDE
    color5 #A347BA
    color13 #C061CB
    color6 #2AA1B3
    color14 #33C7DE
    color7 #D0CFCC
    color15 #FFFFFF    
  '';
  xdg.configFile."kitty/themes/adwaita-dark.conf".text = ''
    selection_background #000000
    selection_foreground #FFFFFF
    background #171421
    foreground #D0CFCC
    cursor #FFFFFF
    color0 #171421
    color8 #5E5C64
    color1 #C01C28
    color9 #F66151
    color2 #26A269
    color10 #33D17A
    color3 #A2734C
    color11 #E9AD0C
    color4 #12488B
    color12 #2A7BDE
    color5 #A347BA
    color13 #C061CB
    color6 #2AA1B3
    color14 #33C7DE
    color7 #D0CFCC
    color15 #FFFFFF
  '';
}
