{ outputs, ... }: {
  programs.ssh = {
    enable = true;
    matchBlocks.net = {
        host = builtins.concatStringsSep " " (builtins.attrNames outputs.nixosConfigurations);
        forwardAgent = true;
    };
  };
}
