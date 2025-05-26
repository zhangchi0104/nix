{inputs, utilities, ...}: 
let
  inherit (inputs) nix-vscode-extensions;
in
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
  system.primaryUser = "alexzhang";
  nixpkgs.overlays = [
    nix-vscode-extensions.overlays.default
  ];

  # Home manager basic setup
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs utilities;
    };
  };

  # machine specific settings
}
