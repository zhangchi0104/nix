{ pkgs, ... }:

{
  programs.lazygit = {
    enable = true;
    package = pkgs.lazygit;
  };

  catppuccin.lazygit.enable = true;
}
