{...} : 

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
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
