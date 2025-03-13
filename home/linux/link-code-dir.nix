{ lib, ... }:
{
  home.activation.linkcodedir = lib.hm.dag.entryAfter ["writeBoundary" "installPackages"] ''
    if [ ! -d "$HOME/code" ] && [ -d "/mnt/data/code" ]; then
      echo "Linking code directory"
      ln -s /mnt/data/code $HOME/code
    fi
  '';
}
