{lib, ...}: 

{
  programs.ssh.matchBlocks = lib.mkAfter {
    "github.com" = {
      hostname = "github.com";
      serverAliveInterval = 60;
    };
  };
}
