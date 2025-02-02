{inputs, ...}:
{

  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];
  home-manager.users.alexzhang = {
    home.username = "alexzhang";
    home.homeDirectory = "/Users/alexzhang";
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
  users.users.alexzhang = {
    name = "alexzhang";
    home = "/Users/alexzhang";
  };
}
