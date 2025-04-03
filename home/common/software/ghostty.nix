{ inputs, pkgs,... }:
let
  isLinux = pkgs.stdenv.isLinux;
in
{
  programs.ghostty = {
    enable = true;
    package = if isLinux then pkgs.ghostty else null;
    settings = {
      macos-titlebar-style = "hidden";
      macos-option-as-alt = true;
      macos-icon="custom-style";
      macos-icon-frame="plastic";
      font-family = "Maple Mono Normal NF";
      font-size = 14;
      background-opacity = 0.8;
      background-blur-radius = 20;
      custom-shader = "${inputs.ghostty-shaders}/bettercrt.glsl";
    };
  };
}
