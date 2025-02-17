{utils, lib, pkgs, ...}:
let
  inherit (utils.constants) opAgentSock;
  cloneDotFiles = lib.hm.dag.entryAfter ["writeBoundary" "installPackages"] ''
    if [ ! -d "$HOME/.dotfiles" ] && [ -f ${opAgentSock} ]; then
      echo "Cloning dotfiles"
      SSH_AUTH_SOCK=${opAgentSock} GIT_SSH_COMMAND="${pkgs.openssh}/bin/ssh" ${pkgs.git}/bin/git clone git@github.com:zhangchi0104/dotfiles.git $HOME/.dotfiles
    fi
  '';
in 
{
  home.activation.cloneDotfiles = cloneDotFiles;
}
