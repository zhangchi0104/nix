{lib, ...}: 
{
  programs.ssh.matchBlocks = lib.mkAfter {
    "github.com" = {
      hostname = "github.com";
      serverAliveInterval = 60;
    };

    "primary-gh" = {
      hostname = "github.com";
      user = "git";
      identityFile = "~/.ssh/ed25519_primary.pub";
      identitiesOnly = true;
    };

    "secondary-gh" = {
      hostname = "github.com";
      user = "git";
      identityFile = "~/.ssh/ed25519_secondary.pub";
      identitiesOnly = true;
    };
  };
}
