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

    "everyoungai-gh" = {
      hostname = "github.com";
      user = "git";
      identityFile = "~/.ssh/ed25519_everyoung.pub";
      identitiesOnly = true;
    };
    "nixos" = {
      hostname = "nixos";
      user = "aris";
      forwardAgent = true;
    };
    "everyoungai-aurora-tunnel" = {
      hostname = "3.26.233.71";
      user = "ec2-user";
      identitiesOnly = true;
      identityFile = "~/.ssh/ed25519_everyoung.pub";
      localForwards = [
        {
          bind.port = 5432;
          host.address= "serverlessv2-cluster.cluster-cqdldkyap7cf.ap-southeast-2.rds.amazonaws.com";
          host.port = 5432;
        }
      ];
    };
  };
}
