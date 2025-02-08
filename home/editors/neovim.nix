{ lib, pkgs, ... }:
let
 linkNeovimConfig = lib.hm.dag.entryAfter ["writeBoundary" "cloneDotfiles"] ''
  if [[ -d ~/.dotfiles ]]; then 
    ${pkgs.stow}/bin/stow -d $HOME/.dotfiles lazyvim
  fi
 '';

in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.activation = lib.mkIf (builtins.getEnv "NIX_SKIP_ACTIVATION" == "") {
    inherit linkNeovimConfig;
  };
}
