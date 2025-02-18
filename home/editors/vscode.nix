{ utils, pkgs, lib, config, inputs, ... }: 
let
  inherit (utils.constants) isLinux;
  darwinConfigNames = {
    cursor = "Cursor";
    vscode = "Code";
  };
  inherit (pkgs.stdenv.hostPlatform) system;
  extensions = inputs.nix-vscode-extensions.extensions.${system};
  mkExtensionDir = pname: "$HOME/.${pname}/extensions";
  mkDarwinConfigName = pname: darwinConfigNames.${pname};
  mkConfigDir = pname: if isLinux 
    then "${config.xdg.configHome}/${pname}/User"
    else "$HOME/Library/Application Support/${mkDarwinConfigName pname}/User";
  cursorExtensionsDir = mkExtensionDir "cursor";
  vscodeExtensionsDir = mkExtensionDir "vscode";
  cursorConfigDir = mkConfigDir "cursor";
  vscodeConfigDir = mkConfigDir "vscode";
  mkTabStop = size: { "editor.tabSize" = size; };
in 
{
  programs.vscode = {
    enable = true;
    # package = utils.functions.mkIfLinux pkgs.vscode;
    extensions = with extensions.vscode-marketplace; [
      # copilot
      github.copilot
      github.copilot-chat

      # remote development
      ms-vscode-remote.vscode-remote-extensionpack

      # catppuccin
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      zhuangtongfa.one-dark-pro

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

      # Misc
      redhat.vscode-yaml
      prisma.prisma
      ms-azuretools.vscode-docker
      editorconfig.editorconfig
    ];
    userSettings = {
      "workbench.colorTheme" = "One Dark Pro Mix";
      "files.autoSave" = "onFocusChange";
      # editor settings
      "editor.fontSize" = 14;
      "editor.fontFamily" = "'JetBrains Mono', monospace";
      "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";
      # tab stop by language
      "[typescriptreact]" = mkTabStop 2;
      "[javascript]" = mkTabStop 2;
      "[javascriptreact]" = mkTabStop 2;
      "[css]" = mkTabStop 2;
      "[less]" = mkTabStop 2;
      "[html]" = mkTabStop 2;
    };
  };
  home.activation.copyVscodeSettingsToCursor = lib.hm.dag.entryAfter ["writeBoundary" "installPackages"] ''
    mkdir -p "${cursorConfigDir}"
    mkdir -p "${cursorExtensionsDir}"
    
    if [ -d "${vscodeConfigDir}" ] && [ -d "${cursorConfigDir}" ]; then
      ln -sf "${vscodeConfigDir}"/settings.json "${cursorConfigDir}"/settings.json
      ln -sf "${vscodeConfigDir}"/tasks.json "${cursorConfigDir}"/tasks.json
      ln -sf "${vscodeConfigDir}"/snippets "${cursorConfigDir}"
    fi

    rm -rf "${cursorExtensionsDir}"/*
    if [ -d "${vscodeExtensionsDir}" ] && [ -d "${cursorExtensionsDir}" ]; then
      cp -r "${vscodeExtensionsDir}"/* "${cursorExtensionsDir}"
      sed -i 's/\/\.vscode/\/\.cursor/g' ${cursorExtensionsDir}/extensions.json
    fi
  '';
}
