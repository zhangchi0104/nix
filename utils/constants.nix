{ nixpkgs, ... }: 
let
  inherit (nixpkgs.stdenv) isDarwin isLinux;
in
{
  inherit isDarwin isLinux;
}
