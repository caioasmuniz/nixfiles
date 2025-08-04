{ ... }: {
  zramSwap = {
    enable = true;
    priority = 1;
    algorithm = "zstd";
    swapDevices = 1;
    memoryPercent = 50;
  };
}
