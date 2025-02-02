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
    };

    # my dotfiles
    dotfiles = {
      url = "github:zhangchi0104/dotfiles";
      flake = false;
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nix-darwin, nixpkgs, ... }@inputs:
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
