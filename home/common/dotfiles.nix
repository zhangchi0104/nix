{lib, pkgs, ...}:
{
  home.activation.cloneDotfiles = lib.hm.dag.entryAfter ["writeBoundary" "installPackages"] ''
    if [ ! -d "$HOME/.dotfiles" ]; then
      echo "Cloning dotfiles"
      ${pkgs.git}/bin/git clone git@github.com:zhangchi0104/dotfiles.git $HOME/.dotfiles
    fi
  '';
}