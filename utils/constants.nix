{ nixpkgs, system }@inputs: 
let
  inherit (nixpkgs.lib.strings) splitString;
  inherit (nixpkgs.lib.lists) last first;
  archWithOs = splitString "-" system;
in
{
  arch = first archWithOs;
  os = last archWithOs;
}
