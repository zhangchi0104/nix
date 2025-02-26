{ utils, pkgs, lib, config, inputs, ... }: 
let
  inherit (utils.constants) isLinux;
  inherit (utils.functions) flatten;
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
  mkFrontendSettings = tabSize: {
    "editor.tabSize" = tabSize;
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  editorSettings = flatten {
    editor.fontSize = 14;
    editor.fontFamily = "'JetBrains Mono', monospace";
    editor.formatOnPaste = true;
    editor.formatOnSave = true;
  };
  terminalSettings =  flatten {
    terminal.integrated.fontFamily = "'JetBrainsMono Nerd Font', monospace";
    terminal.integrated.lineHeight = 1.1;
  };
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

      # Neovim Mode
      asvetliakov.vscode-neovim
    ];
    userSettings = {
      "workbench.colorTheme" = "One Dark Pro Mix";
      "workbench.iconTheme" = "Catppuccin Mocha";
      "files.autoSave" = "onFocusChange";
      
      # tab stop by language
      "[typescriptreact]" = mkFrontendSettings 2;
      "[javascript]" = mkFrontendSettings 2;
      "[javascriptreact]" = mkFrontendSettings 2;
      "[css]" = mkFrontendSettings 2;
      "[less]" = mkFrontendSettings 2;
      "[html]" = mkFrontendSettings 2;

      "extensions.experimental.affinity" = {
        "asvetliakov.vscode-neovim" = 1;
      };
    } // editorSettings // terminalSettings;
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
