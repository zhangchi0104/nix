{
  description = "My flake";

  inputs = {
    
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master"; 
      inputs.nixpkgs.follows = "nixpkgs";

    };
    # home-manager 
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # capuccin - colorscheme
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nix-darwin, nixpkgs, ... }@inputs:
  let
    mkUtils = system: import ./utils {  inherit system nixpkgs;};
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#zhangchis-MacBook-Pro
    darwinConfigurations = { 
      "zhangchis-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [ ./hosts/alex-mbp.nix ];
        specialArgs = {
          inherit inputs; utils = mkUtils "aarch64-darwin";
        };
      };
    };
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/alex-desktop
      ];
      specialArgs = { inherit inputs; utils = mkUtils "aarch64-darwin"; };
    };
  };
}
