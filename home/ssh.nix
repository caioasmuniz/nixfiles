{ outputs, ... }: {
  programs.ssh = {
    enable = true;
    matchBlocks.net = {
      host =
        (builtins.concatStringsSep " " (builtins.attrNames outputs.nixosConfigurations)) + " 192.168.0.172";
      forwardAgent = true;
    };
  };
}
