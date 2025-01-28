{...}: 

{
  imports = [
    # packages
    ../core/software/common
    ../core/software/darwin
    ../core/software/homebrew

    # system settings
    ../core/settings/common
    ../core/settings/darwin 
  ];

  nixpkgs.hostPlatform = "aaarch64-darwin";
  system.stateVersion = 5;

}
