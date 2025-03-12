{ utilities, ... }:

let
  inherit (utilities.constants) opAgentSock;
in 
{   
    programs.ssh.extraConfig = ''
      Host *
        IdentityAgent "${opAgentSock}"
    '';
}
