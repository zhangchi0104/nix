{ nixpkgs, constants, ... }@inputs:
let 
  inherit (nixpkgs.lib.attrsets) mapAttrsToList concatMapAttrs;
  inherit (nixpkgs.lib.path) append;
  inherit (nixpkgs.lib.lists) filter;
  inherit (builtins) match isAttrs;
  inherit (constants) arch os;
  removeAll =  itemsToRemove: allItems:
    filter (item: !builtins.elem item itemsToRemove) allItems;
in
rec {
  inherit removeAll;
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
  sourceDirByOs = dir:
    let
      filesToExclude = [ "default.nix" "darwin.nix" "linux.nix" "linux" "darwin" ];
      files = listDir dir;
      commonFiles = removeAll filesToExclude files;
      osSpecificFiles = filter (file: match ".*${os}(\.nix)?" file != null) files;
      combinedFiles = commonFiles ++ osSpecificFiles;
    in builtins.map (it: append dir it) combinedFiles;
  mkIfLinux = val: if os == "linux" then val else {};
  mkIfDarwin = val: if os == "darwin" then val else {};
  # flatten = attrs:
  #   let
  #     fn = prefix: name: value:
  #       let
  #         foo = 
  #       in 
  #     flatten' = prefix: attrs': {};
  #   in {};
}
