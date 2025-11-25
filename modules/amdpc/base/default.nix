{config, pkgs, ...}:
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

  # Steam
  programs.steam = {
    enable = true;
    package = pkgs.steam;
    gamescopeSession.enable = true;
  };
  programs.gamescope = {
    enable = true;
    package = pkgs.gamescope.overrideAttrs (_: {
      NIX_CFLAGS_COMPILE = ["-fno-fast-math"];
    });
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
      mangohud
      protonplus
      steam-rom-manager
      onlyoffice-desktopeditors
      heroic
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

  virtualisation.oci-containers.containers.siyuan = {
    serviceName = "siyuan";
    image = "b3log/siyuan";
    environment = {
      TZ = "Asia/Jakarta";
      SIYUAN_ACCESS_AUTH_CODE_BYPASS = "true";
      SIYUAN_WORKSPACE_PATH = "/siyuan/workspace";
    };
    volumes = [
      "/siyuan/workspace:/siyuan/workspace:rw"
    ];
    ports = [
      "6806:6806/tcp"
    ];
  };

  services.nginx.virtualHosts."notes.say.id" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:6806";
      proxyWebsockets = true;
      recommendedProxySettings = true;
      extraConfig = ''
        client_max_body_size 50000M;
        proxy_read_timeout   600s;
        proxy_send_timeout   600s;
        send_timeout         600s;
      '';
    };
  };
}

