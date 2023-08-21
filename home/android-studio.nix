{ pkgs, ... }: {
  home.packages = [ pkgs.android-studio ];
  home.sessionVariables = { _JAVA_AWT_WM_NONREPARENTING = 1; };
  wayland.windowManager.hyprland.extraConfig = ''
    windowrulev2 = float,floating:0,class:^(android-.*),title:^(win.*)
    windowrulev2 = float,class:^(android-.*),title:^(Welcome to.*)
    windowrulev2 = center,class:^(android-.*),title:^(Replace All)$
    windowrulev2 = forceinput,class:^(android-.*)
    windowrulev2 = windowdance,class:^(android-.*) # allows IDE to move child windows
  '';
}
