{...}:
{
  boot.supportedFilesystems = [ "nfs" ];
  fileSystems."/mnt/Data_D" = {
    device = "100.112.119.112:/shared";
    fsType = "nfs";
    options = [
      "_netdev"
      "nofail"
      "noauto" 
      "x-systemd.automount" 
      "x-systemd.idle-timeout=600s"
      "x-systemd.device-timeout=10s"
      "x-systemd.requires=network-online.target"
    ];
  };
}
