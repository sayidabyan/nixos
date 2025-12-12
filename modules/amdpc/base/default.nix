{inputs, config, pkgs, ...}:
{
  #networking.hostId = "427f1aeb";
  #boot.supportedFilesystems.zfs = true;
  #boot.zfs.package = pkgs.zfs_cachyos;
  users.groups.zfs-users = {
    gid = 1999;
  };
  users.users.sayid = {
    extraGroups = [ "zfs-users" ];
  };

  boot.kernelParams = [ 
    "amdgpu.ppfeaturemask=0xffffffff" # enable radeon oc control(?)
    # fix nic/ethernet issue (?)
    "pcie_port_pm=off"
    "pcie_aspm.policy=performance"
  ];

  boot.kernelModules = [ "kvm-amd" "ntsync" ];

  # Mostly Radeon Related
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  
  home-manager.users.sayid = {...}: {
    home.packages = with pkgs; [
      cider-2
      lact
      onlyoffice-desktopeditors
      sysstat
      vscodium
    ];
  };
  systemd.services.lactd = {
    description = "AMDGPU Control Daemon";
    after = ["multi-user.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
    };
    enable = true;
  };

  # udev rules for dualsense
  services.udev.extraRules = ''
    # PS5 DualSense controller over USB hidraw
    # USB
    ATTRS{name}=="Sony Interactive Entertainment DualSense Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
    # Bluetooth
    ATTRS{name}=="DualSense Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';

  services.desktopManager.plasma6.enable = true;
}
