{ pkgs, catppuccin, ... }: {
  programs.bat = {
    enable = true;
    package = pkgs.bat;
  };

  catppuccin.bat.enable = true;
} 