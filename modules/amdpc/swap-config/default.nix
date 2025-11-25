{...}:
{

  swapDevices = [ {
    device = "/var/lib/swapfile";
      size = 16*1024;
  } ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };
}
