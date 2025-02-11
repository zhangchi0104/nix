{...}@inputs: 

{
  constants = import ./constants.nix { inherit inputs; };
  functions = import ./functions.nix { inherit inputs; };
}
