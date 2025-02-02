{ pkgs, inputs, ... }:
let 
  keybinds = {
    normal = {
      "bind \"Ctrl K\"" = {
        "Clear;" = [];
      };
    };
  };
in
{
  programs.zellij = {
    enable = true;
    package = pkgs.zellij;
    settings = {
      keybinds = keybinds;
    };
  };

  # home.file.zellij = {
  #   source = "${inputs.dotfiles}/zellij/config.kdl";
  #   target = ".config/zellij/config.kdl";
  # };
  
  catppuccin.zellij.enable = true;
  
}
