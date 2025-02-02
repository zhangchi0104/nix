{...}:

{ 
  imports = [
    ./1password.nix
    ./hosts.nix
    
  ];
  programs.ssh = {
    enable = true;
    forwardAgent = true;
  };
}
