{ pkgs, ... }:

{ 
  environment.systemPackages = with pkgs; [
    warp-terminal
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
