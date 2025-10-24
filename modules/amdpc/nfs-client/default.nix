{...}:
{
  users.groups.nfs-users = {
    gid = 2121;
  };
  users.users.sayid = {
    extraGroups = [ "nfs-users" ];
  };
  fileSystems."/mnt/Data_D" = {
    device = "100.112.119.112:/media/external/shared";
    fsType = "nfs";
    options = [
      "_netdev"
      "noauto" 
      "x-systemd.automount" 
      "x-systemd.idle-timeout=600s"
      "x-systemd.device-timeout=10s"
      "vers=4"
    ];
  };
  fileSystems."/mnt/Music" = {
    device = "100.112.119.112:/media/external/media/music";
    fsType = "nfs";
    options = [
      "_netdev"
      "noauto" 
      "x-systemd.automount" 
      "x-systemd.idle-timeout=600s"
      "x-systemd.device-timeout=10s"
      "vers=4"
    ];
  };
}
