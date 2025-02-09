# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  users.users.aris = {
     isNormalUser = true;
     extraGroups = ["wheel" "networkmanager"];
     home = "/home/aris";
     name = "Aris Tendou";
   };
}

