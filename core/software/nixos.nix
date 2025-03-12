{ config, lib, pkgs, ... }:

{ 
  environment.systemPackages = with pkgs; [
    ghostty
    code-cursor
    slack
    postman
    android-tools
    gcc
    gnome-tweaks
    qq
    tailscale
  ];
}
