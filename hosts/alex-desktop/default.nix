{ inputs, ... }:

{
  imports = [

   # Generic Settings
   ../../core/settings/common.nix
   ../../core/software/common.nix
   # OS Specific Settings
   ../../core/settings/nixos
   ../../core/software/nixos.nix
   # machine specific settings
   ./local-settings.nix           # users
   ./hardware-configuration.nix   # hardware configurations

   # home manager
   ../../home/alex-desktop-home.nix
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
