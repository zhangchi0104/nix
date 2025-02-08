{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    git-lfs
    git-credential-manager
  ];

  programs.git = {
    enable = true;
    package = pkgs.git;
    userName = "Alex Zhang";
    userEmail = "alex@otakuma.dev";
   
    signing = {
      signByDefault = true;
      
    };
  };
}
