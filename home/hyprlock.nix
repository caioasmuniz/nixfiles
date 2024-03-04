{ ... }: {
  programs.hyprlock = {
    enable = true;
    backgrounds = [{ blur_passes = 2; }];
  };
}
