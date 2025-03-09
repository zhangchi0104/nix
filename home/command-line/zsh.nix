{pkgs, config, ...} :
let
  androidHome = if isDarwin then "$HOME/Library/Android/sdk" else "$HOME/Android/sdk";
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
      gco = "git checkout";
      gc = "git commit";
      zlw = "zellij attach --create work";
      zlp = "zellij attach --create presonal";
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
    sessionVariables = {
      ANDROID_HOME = androidHome;
    };
    initExtraFirst=''
      include() {
        if [ -f $1 ]; then
          source $1
        fi
      }
    '';
    initExtra = ''
      include ~/.zshrc.local
      include ~/.config/zshrc.local
    '';
  };
}
