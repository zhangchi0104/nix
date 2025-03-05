{pkgs, inputs, ...}: 
let
  inherit (inputs) nix-vscode-extensions;
in
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    nix-vscode-extensions.overlays.default
  ]; 
  nix.settings.experimental-features = "nix-command flakes";
  fonts.packages = with pkgs.nerd-fonts; [
    jetbrains-mono
    monaspace
  ];
}
