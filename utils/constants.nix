{ nixpkgs, system }@inputs: 
let
  inherit (nixpkgs.lib.strings) splitString;
  inherit (nixpkgs.lib.lists) last first;
  archWithOs = splitString "-" system;
in
{
  arch = first archWithOs;
  os = last archWithOs;
  isDarwin = os == "darwin";
  isLinux = os == "linux";
  opAgentSock = if isDarwin then "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" else "$HOME/.1password/agent.sock";

}
