{ utilities, ... }:

let
  inherit (utilities.constants) opAgentSock;
in 
{   # I want
    programs.ssh.extraConfig = ''
      Host *
        IdentityAgent "${opAgentSock}"
    '';
}
