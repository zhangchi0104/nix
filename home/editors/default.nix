{ utilities, ... }:
let
  inherit (utilities.functions) sourceDir;

in
{
  imports = sourceDir ./.;
}