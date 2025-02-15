{ nixpkgs, system }@inputs:
let
  constants = import ./constants.nix inputs;
  inputsWihtConstants = nixpkgs.lib.updateManyAttrsByPath [{
    path = ["constants"];
    update = old: constants;
  }] inputs;
in
{
  inherit constants;
  functions = import ./functions.nix inputsWihtConstants;
}
