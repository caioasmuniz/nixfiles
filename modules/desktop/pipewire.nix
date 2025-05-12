{ pkgs, ... }: {
  security.rtkit.enable = true;
  environment.systemPackages = [ pkgs.pwvucontrol ];
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
