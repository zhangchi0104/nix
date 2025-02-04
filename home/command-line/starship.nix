{...} : 

{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.starship.settings = {
    
    aws = {
      disabled = true;
     
    };
  };
}
