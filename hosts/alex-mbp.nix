{inputs, utils, ...}: 

{
  imports = [
    # home manager core
    inputs.home-manager.darwinModules.home-manager
    # packages
    ../core/software
    # system settings
    ../core/settings
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
      inherit inputs utils;
    };
  };

  # machine specific settings
}
