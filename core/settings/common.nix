{pkgs, inputs, ...}: 
let
  inherit (inputs) nix-vscode-extensions;
  mapleFonts = with pkgs.maple-mono; [
    NF NF-CN
  ];
in
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    nix-vscode-extensions.overlays.default
  ]; 
  nix.settings.experimental-features = "nix-command flakes";
  fonts.packages = (with pkgs.nerd-fonts; [
    jetbrains-mono
    monaspace
  ]) ++ mapleFonts;
    services.tailscale.enable = true;

}
