{pkgs, ...}: 

{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";
  fonts.packages = with pkgs.nerd-fonts; [
    jetbrains-mono
    monaspace
  ];
}
