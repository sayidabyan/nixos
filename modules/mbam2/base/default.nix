# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = false;
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;
  
  boot = {
    consoleLogLevel = 0;
    kernelParams = [ "apple_dcp.show_notch=1" ];
  };

  hardware.graphics = {
    enable = true;
  };
  hardware.asahi = {
    useExperimentalGPUDriver = true;
    experimentalGPUInstallMode = "replace";
    withRust = true;
    setupAsahiSound = true;
  };
  
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  # networking.wireless.iwd = {
  #   enable = true;
  #   settings.General.EnableNetworkConfugiration = true;
  # };
  
  home-manager.users.sayid = {...}:
  {
    home.packages = with pkgs; [
      telegram-desktop
    ];
  };
  
}

