{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    font = {
      size = 10;
      name = "FiraCode Nerd Font";
      package = pkgs.nerd-fonts.fira-code;
    };
    extraConfig = "include current-theme.conf";
    settings = {
      cursor_shape = "beam";
      cursor_beam_thickness = "1.5";
      cursor_blink_interval = 1;
      cursor_stop_blinking_after = 0;

      mouse_hide_wait = "3.0";
      focus_follows_mouse = "yes";

      detect_urls = "yes";
      url_style = "straight";

      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = "yes";
      resize_draw_strategy = "size";

      draw_minimal_borders = "yes";
      window_border_width = "0.5pt";
      window_padding_width = "0.5";
      window_margin_width = 0;

      tab_bar_edge = "bottom";
      tab_bar_margin_width = "0.0";
      tab_bar_style = "powerline";
      tab_bar_align = "left";
      tab_bar_min_tabs = 2;
      tab_powerline_style = "round";
      tab_activity_symbol = "none";
      tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}";
      active_tab_title_template = "none";

      background_opacity = "0.6";
      dynamic_background_opacity = "yes";

      enable_audio_bell = "no";
      allow_remote_control = "yes";
      shell_integration = "enabled";
      linux_display_server = "wayland";
    };
  };
  xdg.configFile = {
    "kitty/themes/adwaita.conf".text = ''
      background                #fcfcfc
      foreground                #504e55

      selection_background      #deddda
      selection_foreground      #5e5c64

      url_color                 #1a5fb4

      cursor                    #504e55
      cursor_text_color         #fcfcfc

      active_border_color       #c0bfbc
      inactive_border_color     #f6f5f4
      bell_border_color         #ed333b
      visual_bell_color         none

      active_tab_background     #b0afac
      active_tab_foreground     #504e55
      inactive_tab_background   #deddda
      inactive_tab_foreground   #5e5c64
      tab_bar_background        none
      tab_bar_margin_color      none

      color0                    #fcfcfc
      color1                    #ed333b
      color2                    #57e389
      color3                    #ff7800
      color4                    #62a0ea
      color5                    #9141ac
      color6                    #5bc8af
      color7                    #deddda

      color8                    #9a9996
      color9                    #f66151
      color10                   #8ff0a4
      color11                   #ffa348
      color12                   #99c1f1
      color13                   #dc8add
      color14                   #93ddc2
      color15                   #f6f5f4'';

    "kitty/themes/adwaita-dark.conf".text = ''
      background                #1d1d1d
      foreground                #deddda

      selection_background      #303030
      selection_foreground      #c0bfbc

      url_color                 #1a5fb4

      cursor                    #deddda
      cursor_text_color         #1d1d1d

      active_border_color       #4f4f4f
      inactive_border_color     #282828
      bell_border_color         #ed333b
      visual_bell_color         none

      active_tab_background     #242424 
      active_tab_foreground     #fcfcfc
      inactive_tab_background   #303030
      inactive_tab_foreground   #b0afac
      tab_bar_background        none
      tab_bar_margin_color      none

      color0                    #1d1d1d
      color1                    #ed333b
      color2                    #57e389
      color3                    #ff7800
      color4                    #62a0ea
      color5                    #9141ac
      color6                    #5bc8af
      color7                    #deddda

      color8                    #9a9996
      color9                    #f66151
      color10                   #8ff0a4
      color11                   #ffa348
      color12                   #99c1f1
      color13                   #dc8add
      color14                   #93ddc2
      color15                   #f6f5f4
    '';
  };
}
