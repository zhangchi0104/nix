{inputs, ...}:
{

  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager.users.aris = {
    home.username = "aris";
    home.homeDirectory = "/home/aris";
    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
    imports = [
      inputs.catppuccin.homeManagerModules.catppuccin
      ./common/dotfiles.nix
      ./command-line
      ./editors
      ./ssh
    ];
    catppuccin = {
      flavor = "mocha";
    };
  };
}
