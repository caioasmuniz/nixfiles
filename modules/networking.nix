{ ... }: {
    networking = {
    hostName = "nixos";
    wireless.iwd.enable = true;
    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
        powersave = false;
      };
    };
  };
 }
