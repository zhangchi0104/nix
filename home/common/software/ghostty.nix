{ utils, pkgs,... }:
let
  inherit (utils.functions) mkLinux;
in 
{
  programs.ghostty = {
    enable = true;
    package = mkLinux pkgs.ghostty;
  };
}
