{inputs, lib, ...}:
{

  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager.users.aris = {
    home.username = "aris";
    home.homeDirectory = "/home/aris";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
    imports = [
      inputs.catppuccin.homeManagerModules.catppuccin
      ./common/dotfiles.nix
      ./command-line
      ./editors
      ./ssh
      ./linux/gnome
      ./linux/link-code-dir.nix
    ];
    catppuccin = {
      flavor = "mocha";
    };
    
  };
}
