{
  description = "My flake";

  inputs = {
    
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    nix-vscode-extensions = { 
      url = "github:nix-community/nix-vscode-extensions/master";
      inputs.nixpkgs.follows = "nixpkgs";
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

    # ghostty shaders
    ghostty-shaders = {
      url = "github:hackr-sh/ghostty-shaders";
      flake = false;
    }; 
  };

  outputs = { self, nix-darwin, nixpkgs, nix-vscode-extensions,... }@inputs:
  let
    mkUtils = system: import ./utilities {  inherit system nixpkgs;};
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#zhangchis-MacBook-Pro
    darwinConfigurations = { 
      "zhangchis-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [ ./hosts/alex-mbp.nix ];
        specialArgs = {
          inherit inputs; utilities = mkUtils "aarch64-darwin";
        };
      };
    };
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/alex-desktop
      ];
      specialArgs = { inherit inputs; utilities = mkUtils "x86_64-linux"; };
    };
  };
}

