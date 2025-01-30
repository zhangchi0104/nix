{inputs, ...}: 

{
  imports = [
    # home manager core
    inputs.home-manager.darwinModules.home-manager
    # packages
    ../core/software/common.nix 
    ../core/software/darwin.nix
    ../core/software/homebrew.nix

    # system settings
    ../core/settings/common.nix
    ../core/settings/darwin.nix

    # home manager
    ../home/alex-mbp-home.nix
  ];
  # nix darwin bacsic setup
  nixpkgs.config.hostPlatform = "aarch64-darwin";
  system.stateVersion = 5;

  # Home manager basic setup
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
    };
  };

  # machine specific settings
}
