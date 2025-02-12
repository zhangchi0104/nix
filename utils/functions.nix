{ nixpkgs, constants, ... }@inputs:
let 
  inherit (nixpkgs.lib.attrsets) mapAttrsToList;
  inherit (nixpkgs.lib.path) append;
  inherit (builtins) filter;
in
rec {
  attrKeys = attrs: if (!builtins.isAttrs attrs) 
    then []
    else mapAttrsToList(name: value: name) attrs;
  listDir = dir:
    let
      fileAttrs = builtins.readDir dir;
      fileNames = attrKeys fileAttrs;
    in fileNames;
  sourceDir = dir:
    let
     files = listDir dir;
     sourceFiles = filter (file: file != "default.nix") files;
    in builtins.map (it: append dir it) sourceFiles;


}
