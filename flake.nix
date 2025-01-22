{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =  {self, nix-darwin, ... }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = 
        let 
          pythonWithPackages = pkgs.python3.withPackages(ps: [ps.pynvim ps.rich ps.pydantic]);
        in
        [ 
          pkgs.neovim
          pkgs.git
          pkgs.zellij
          pkgs.btop
          pkgs.bat
          pkgs.lazygit
          pkgs.starship
          pkgs.nodejs_20
          pkgs.bun
          pkgs.yarn
          pkgs.zoxide
          pkgs.wget
          pkgs.curl
          pkgs.stow
          pythonWithPackages
        ]; 
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Homebrew Configuration
      homebrew  = {
        enable = true;
        brews = [];
        casks = [
          "ghostty"
          "cursor"
          "android-platform-tools"
          "slack" 
        ];
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#zhangchis-MacBook-Pro
    darwinConfigurations."zhangchis-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
