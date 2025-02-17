{ utils, ... }:

let
  inherit (utils.constants) opAgentSock;
in 
{   # I want
    programs.ssh.extraConfig = ''
      Host *
        IdentityAgent "${opAgentSock}"
    '';
}
