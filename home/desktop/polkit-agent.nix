{ pkgs, ... }: {
  systemd.user.services.hyprland-polkit-authentication-agent = {
    Unit = {
      Description = "Hyprland Polkit authentication agent";
      Documentation = "https://gitlab.freedesktop.org/polkit/polkit/";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "always";
      BusName = "org.freedesktop.PolicyKit1.Authority";
    };
    Install.WantedBy = [ "hyprland-session.target" ];
  };
}
