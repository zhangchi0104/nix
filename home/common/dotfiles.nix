{lib, pkgs, ...}:
let
  op-agent-sock = if pkgs.stdenvNoCC.isDarwin
    then "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else "$HOME/.1password/agent.sock";
in 
{
  home.activation.cloneDotfiles = lib.hm.dag.entryAfter ["writeBoundary" "installPackages"] ''
    if [ ! -d "$HOME/.dotfiles" ]; then
      echo "Cloning dotfiles"
      SSH_AUTH_SOCK=${op-agent-sock} GIT_SSH_COMMAND="${pkgs.openssh}/bin/ssh" ${pkgs.git}/bin/git clone git@github.com:zhangchi0104/dotfiles.git $HOME/.dotfiles
    fi
  '';
}