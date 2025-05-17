{ pkgs, ... }:

{
  programs.lazygit = {
    enable = true;
    package = pkgs.lazygit;
    settings = {
      services = {
        "github.com" = "github:github.com";
      };
    };
  };

  catppuccin.lazygit.enable = true;
}
