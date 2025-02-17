{ utils, ... }:
let
  inherit (utils.functions) sourceDir;

in
{
  imports = sourceDir ./.;
}