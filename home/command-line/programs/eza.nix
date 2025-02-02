{pkgs, ...} : 

{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.eza;
  };
}