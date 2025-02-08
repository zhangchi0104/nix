# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = lib.mkDefault "Australia/Sydney";

  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  services.xserver.enable = true;
  nixpkgs.config.allowUnfree = true;


  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  system.stateVersion = "24.11"; # Did you read the comment?

}

