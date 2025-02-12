{ utils, pkgs,... }:
let
  isLinux = pkgs.stdenv.isLinux;
in
{
  programs.ghostty = {
    enable = true;
    package = if isLinux then pkgs.ghostty else null;
    settings = {
      macos-titlebar-style = "transparent";
      macos-option-as-alt = true;
      macos-icon="custom-style";
      macos-icon-frame="plastic";
      font-family = "JetBrainsMono Nerd Font Mono";
      font-size = 14;
      background-opacity = 0.8;
      background-blur-radius = 20;
    };
  };
}
