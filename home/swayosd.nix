{ ... }: {
  services.swayosd.enable = true;
  wayland.windowManager.hyprland.extraConfig = ''
    bindle=, XF86AudioRaiseVolume, exec, swayosd --output-volume raise 5
    bindle=, XF86AudioLowerVolume, exec, swayosd --output-volume lower 5

    bindle=SHIFT, XF86AudioRaiseVolume, exec, swayosd --input-volume raise 5
    bindle=SHIFT, XF86AudioLowerVolume, exec, swayosd --input-volume lower 5

    bind=, XF86AudioMute, exec, swayosd --output-volume mute-toggle
    bind=, XF86AudioMicMute, exec, swayosd --input-volume mute-toggle

    binde=, XF86MonBrightnessUp, exec, light -A 10
    binde=, XF86MonBrightnessDown, exec, light -U 10

    bindl=, Caps_Lock, exec, swayosd --caps-lock-led input0::capslock
    binde=, XF86MonBrightnessUp, exec, swayosd --brightness raise 5
    binde=, XF86MonBrightnessDown, exec, swayosd --brightness lower 5
  '';
}
