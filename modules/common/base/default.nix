# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, device, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  security.polkit.enable = true;

  networking.hostName = "nixos-${device}"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        UserspaceHID=true;
      };
    };
  };

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the Desktop Environment/ Display Manager.
  services.displayManager.gdm.enable = true;

  # Fix Network Manager Error
  systemd.services.NetworkManager-wait-online.enable = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable android udev rules
 # services.udev.packages = [
 #   pkgs.android-udev-rules
 # ];
  
  # Enable CUPS to print documents.
  services.printing.enable = true;
  hardware.ledger.enable = true;
  
  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sayid = {
    isNormalUser = true;
    description = "sayid";
    extraGroups = [ "networkmanager" "wheel"];
  };

  services.flatpak.enable = true;

  # Allow Unfree
  nixpkgs.config.allowUnfree = true;
  # Enable normal binary execution(?)
  programs.nix-ld.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup-" + pkgs.lib.readFile "${pkgs.runCommand "timestamp" {} "echo -n `date '+%Y%m%d%H%M%S'` > $out"}";
  home-manager.users.sayid = { pkgs, ... }: {
    home.packages = with pkgs; [
      aiken
      bc
      bottom
      brave
      btop
      cava
      dbeaver-bin
      (pkgs.discord.override {
        withVencord = true;
        withOpenASAR = true;
      })
      dnsutils
      fastfetch
      htop
      libnotify
      neofetch
      nettools
      nix-prefetch-git
      nix-prefetch
      nvtopPackages.amd
      p7zip
      parsec-bin
      pavucontrol
      pfetch
      qbittorrent
      rhythmbox
      scrcpy
      speedtest-cli
      telegram-desktop
      unzip
      vesktop
      xviewer
      yazi
      yt-dlp
    ];
    home.username = "sayid";
    home.homeDirectory = "/home/sayid";
    home.stateVersion = "25.11";

    programs.home-manager.enable = true;
    programs.gh.enable = true;
    
    # Direnv
    programs.direnv.enable = true;
    programs.direnv.enableZshIntegration = true;
    programs.direnv.nix-direnv.enable = true; # prevent garbage collection
    
    # Temporary workaround brave
    xdg.desktopEntries = {
      brave-browser = {
        name = "Brave Web Browser";
        icon = "brave-browser";
        terminal = false;
        type = "Application";
        categories = ["Network" "WebBrowser"];
        exec = "brave --disable-features=WaylandWpColorManagerV1 %U";
      };
      t3chat = {
        name = "T3chat";
        icon = "/home/sayid/nixos/icons/t3chat.svg";
        terminal = false;
        type = "Application";
        categories = ["Application"];
        exec = "brave --disable-features=WaylandWpColorManagerV1 %U --app=https://t3.chat";
        settings = {
          StartupWMClass="T3chat";
        };
      };
      steam-gamescope = {
        name = "Steam Gamescope";
        comment = "Launch Steam in Gamescope";
        exec = "gamescope -e -f -h 1440 -r 144 --prefer-output=DP-1 -- steam -gamepadui";
        icon = "steam";
        type = "Application";
        terminal = false;
        categories = [ "Game" ];
      };
    };
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.obs-studio = {
    enable = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
   programs.dconf.enable = true; 

  # programs.nh = {
  #  enable = true;
  #  clean.enable = true;
  #  clean.extraArgs = "--keep 20";
  #};
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
