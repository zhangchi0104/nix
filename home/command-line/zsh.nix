{...} : 

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      lg = "lazygit";
      e = "$EDITOR";
    };
    autosuggestion = {
      enable = true;
    };

    syntaxHighlighting = {
      enable = true;
    };
    
    history = {
      extended = true;
    };
  };
}
