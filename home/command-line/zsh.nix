{pkgs, lib, config, ...} :

let
  androidHome = if isDarwin then "$HOME/Library/Android/sdk" else "$HOME/Android/sdk";
  isDarwin = pkgs.stdenv.isDarwin;
  osswitch-cmd = if isDarwin 
    then "sudo darwin-rebuild switch --flake ~/.config/nix" 
    else "sudo nixos-rebuild switch --flake ~/.config/nix";
  initExtraFirst=lib.mkOrder 500 ''
      if [ $__ZSH_DEBUG ]; then
        echo $PATH
        echo $(which mv)
        echo $(which dirname)
        echo $(which mkdir)
      fi
      include() {
        if [ -f $1 ]; then
          source $1
        fi
      }
      autoload -U edit-command-line
      zle -N edit-command-line
      bindkey -M vicmd v edit-command-line
    '';
  initExtra = lib.mkOrder 1000 ''
      include ~/.zshrc.local
      include ~/.config/zshrc.local
    '';

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
    initContent = lib.mkMerge [ initExtraFirst initExtra ];
  };
}
