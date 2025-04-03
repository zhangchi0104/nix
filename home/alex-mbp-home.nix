{inputs, ...}:
{

  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];
  home-manager.users.alexzhang = {
    home.username = "alexzhang";
    home.homeDirectory = "/Users/alexzhang";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
    imports = [
      inputs.catppuccin.homeModules.catppuccin
      ./common/dotfiles.nix
      ./common/software
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
