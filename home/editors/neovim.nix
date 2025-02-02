{ lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  home.activation = {
    linkNeovimConfig = lib.hm.dag.entryAfter ["writeBoundary" "cloneDotfiles"] ''
      ${pkgs.stow}/bin/stow -d $HOME/.dotfiles lazyvim
    '';
  };
}