{pkgs, ...} :
let
  isDarwin = pkgs.stdenv.isDarwin;
  osswitch-cmd = if isDarwin 
    then "darwin-rebuild switch --flake ~/.config/nix" 
    else "sudo nixos-rebuild switch --flake ~/.config/nix";
in
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      lg = "lazygit";
      e = "$EDITOR";
      oswitch = osswitch-cmd;
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
