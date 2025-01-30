{...}: 

{
  programs.ssh.matchBlocks = {
    "github.com" = {
      hostname = "github.com";
      serverAliveInterval = 60;
    };
  };
}
