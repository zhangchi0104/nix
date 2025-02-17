{ utils, pkgs, lib, config, ... }: 
let
  inherit (utils.constants) isLinux;
  mkExtensionDir = pname: "~/.${pname}/extensions";
  mkConfigDir = pname: if isLinux 
    then "${config.xdg.configHome}/${pname}/User"
    else "~/Library/Application Support/${pname}/User";
  cursorExtensionsDir = mkExtensionDir "cursor";
  vscodeExtensionsDir = mkExtensionDir "vscode";
  cursorConfigDir = mkConfigDir "cursor";
  vscodeConfigDir = mkConfigDir "vscode";
in 
{
  programs.vscode = {
    enable = true;
    # package = utils.functions.mkIfLinux pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      # copilot
      github.copilot
      github.copilot-chat

      # remote development
      ms-vscode-remote.vscode-remote-extensionpack

      # catppuccin
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons

      # nix
      bbenoist.nix

      # python
      ms-python.vscode-pylance
      ms-python.python
      ms-python.isort
      ms-python.debugpy
      charliermarsh.ruff
      
      # rust
      rust-lang.rust-analyzer

      # Typescript / Javascript
      bradlc.vscode-tailwindcss
      wix.vscode-import-cost
      esbenp.prettier-vscode
      dsznajder.es7-react-js-snippets

      # Misc
      redhat.vscode-yaml
      Prisma.prisma
      ms-azuretools.vscode-docker
      EditorConfig.EditorConfig
    ];
  };
  home.activation.copyVscodeSettingsToCursor = lib.hm.dag.entryAfter ["writeBoundary" "installPackages"] ''
    mkdir -p ${cursorConfigDir}
    if [ -d ${vscodeConfigDir} ] && [ -d ${cursorConfigDir} ]; then
      cp -r ${vscodeConfigDir}/* ${cursorConfigDir}
    fi

    mkdir -p ${cursorExtensionsDir}
    if [ -d ${vscodeExtensionsDir} ] && [ -d ${cursorExtensionsDir} ]; then
      cp -r ${vscodeExtensionsDir}/* ${cursorExtensionsDir}
    fi
  '';
}