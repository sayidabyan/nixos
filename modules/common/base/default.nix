# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, device, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;

  boot.loader.efi.canTouchEfiVariables = true;

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    options hid_apple fnmode=0
  '';
  security.polkit.enable = true;

  networking.hostName = "nixos-${device}"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  hardware.bluetooth = {
    enable = true;
  };

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

#  i18n.extraLocaleSettings = {
#   LC_ADDRESS = "en_US.UTF-8";
#   LC_IDENTIFICATION = "en_US.UTF-8";
#   LC_MEASUREMENT = "en_US.UTF-8";
#   LC_MONETARY = "en_US.UTF-8";
#   LC_NAME = "en_US.UTF-8";
#   LC_NUMERIC = "en_US.UTF-8";
#   LC_PAPER = "en_US.UTF-8";
#   LC_TELEPHONE = "en_US.UTF-8";
#   LC_TIME = "en_US.UTF-8";
# };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Desktop Environment/ Display Manager.
 
  services.xserver.displayManager.gdm = {
    enable = true;
    autoSuspend = false;
  };
  # services.desktopManager.cosmic.enable = true;
  # services.displayManager.cosmic-greeter.enable = true;

  # Fix Network Manager Error
  systemd.services.NetworkManager-wait-online.enable = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable android udev rules
  services.udev.packages = [
    pkgs.android-udev-rules
  ];
  
  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true; # For 32 bit applications
  hardware.ledger.enable = true;
  
  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sayid = {
    isNormalUser = true;
    description = "sayid";
    extraGroups = [ "networkmanager" "wheel"];
    # packages = with pkgs; [
    #  firefox
    #  thunderbird
    # ];
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
      bc
      bitwarden-desktop
      bottom
      brave
      btop
      deno
      fastfetch
      htop
      nautilus
      neofetch
      nodePackages.typescript-language-server
      pavucontrol
      pfetch
      p7zip
      radeontop
      rhythmbox
      signal-desktop
      speedtest-cli
      transmission_4-gtk
      ventoy
      vlc
      vscode-fhs
    ];
    home.username = "sayid";
    home.homeDirectory = "/home/sayid";
    home.stateVersion = "24.11";
    programs.home-manager.enable = true;
    programs.obs-studio = {
      enable = true;
      plugins = [ pkgs.obs-studio-plugins.droidcam-obs ];
    };
    programs.gh.enable = true;
    
    # Direnv
    programs.direnv.enable = true;
    programs.direnv.enableZshIntegration = true;
    programs.direnv.nix-direnv.enable = true; # prevent garbage collection
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
