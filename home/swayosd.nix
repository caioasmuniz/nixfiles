{ pkgs, inputs, config, lib, ... }:
let
  cfg = config.services.swayosd;
  swayosd = pkgs.swayosd.overrideAttrs (old: {
    src = inputs.swayosd;
    cargoDeps = pkgs.rustPlatform.fetchCargoTarball {
      hash = "sha256-VjU7+d2WDEuQoREucGH1Z3rsevYt9VxJ8YjnLGK6boY=";
      src = inputs.swayosd;
    };
    buildInputs = with pkgs;[
      brightnessctl
      gtk-layer-shell
      libevdev
      libinput
      libpulseaudio
      udev
      sassc
    ];
    patches = [ ./swayosd_systemd_paths.patch ];
  });
in
{

  home.packages = [ pkgs.brightnessctl ];
  services.swayosd = {
    enable = true;
    package = swayosd;
  };
  wayland.windowManager.hyprland.extraConfig = ''
    bindle=, XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise 5
    bindle=, XF86AudioLowerVolume, exec, swayosd-client --output-volume lower 5

    bindle=SHIFT, XF86AudioRaiseVolume, exec, swayosd-client --input-volume raise 5
    bindle=SHIFT, XF86AudioLowerVolume, exec, swayosd-client --input-volume lower 5

    bind=, XF86AudioMute, exec, swayosd-client --output-volume mute-toggle
    bind=, XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle

    bindl=, Caps_Lock, exec, swayosd-client --caps-lock-led input0::capslock
    binde=, XF86MonBrightnessUp, exec, swayosd-client --brightness raise
    binde=, XF86MonBrightnessDown, exec, swayosd-client --brightness lower
  '';
}
