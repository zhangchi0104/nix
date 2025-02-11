{ nixpkgs, ... }:
let 

  inherit (nixpkgs.lib.attrsets) mapAttrsToList;

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
}
