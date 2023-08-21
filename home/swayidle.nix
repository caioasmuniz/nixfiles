{ pkgs, ... }: {
  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.gtklock}/bin/gtklock";
      }
      {
        event = "lock";
        command = "${pkgs.gtklock}/bin/gtklock";
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "lock";
      }
      # {
      #   timeout = 300;
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
