{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.nautilus
  ];
  services = {
    gvfs.enable = true;
    gnome.sushi.enable = true;
  };
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "ghostty";
  };
}
