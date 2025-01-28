{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =  {self, nix-darwin, nixpkgs }@inputs:
  
  {
  
      # Build darwin flake using:
    # $ darwin-rebuild build --flake .#zhangchis-MacBook-Pro
    darwinConfigurations = { 
      "zhangchis-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [ ./hosts/alex-mbp.nix ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
