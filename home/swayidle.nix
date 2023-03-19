{ pkgs, ... }: {
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
      {
        event = "lock";
        command = "${pkgs.gtklock}/bin/gtklock";
      }
    ];
    timeouts = [
      {
        timeout = 310;
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
      # {
      #   timeout = 310;
      #   command = ''
      #     ${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.gnugrep}/bin/grep running
      #     if [ $? == 1 ]; then
      #       ${pkgs.systemd}/bin/systemctl suspend
      #     fi
      #     '';
      # }
    ];
  };
}
