{ nixpkgs, ... }:
let 
  inherit (nixpkgs.lib.attrsets) mapAttrsToList;
  inherit (nixpkgs.stdenv) isDarwin isLinux;

  helperFns = {
    attrKeys = attrs: if (!builtins.isAttrs attrs) 
      then []
      else mapAttrsToList(name: value: name) attrs;
  };
in
{
  inherit (helperFns) attrKeys;
  listDir = dir:
    let
      inherit (helperFns) attrKeys;
      fileAttrs = builtins.readDir dir;
      fileNames = attrKeys fileAttrs;
    in fileNames;
  mkDarwin = v : if isDarwin then v else null;
  mkLinux = v : if isLinux then v else null;
  mkDarwinOrElse = v: elseVal: if isDarwin then v else elseVal;
  mkLinuxOrElse = v: elseVal: if isLinux then v else elseVal;
}
