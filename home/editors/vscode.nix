{ utilities, pkgs, ... }: 
let
  inherit (utilities.functions) flatten;
  mkFrontendSettings = tabSize: {
    "editor.tabSize" = tabSize;
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  editorSettings = flatten {
    editor.fontSize = 14;
    editor.fontLigatures = true;
    editor.fontFamily = "'Maple Mono Normal NF', 'JetBrains Mono', monospace";
    editor.formatOnPaste = true;
    editor.formatOnSave = true;
  };
  terminalSettings =  flatten {
    terminal.integrated.fontFamily = "'JetBrainsMono Nerd Font', monospace";
    terminal.integrated.lineHeight = 1.1;
  };
in 
{
  programs.vscode.enable = true;
  programs.vscode.package = pkgs.code-cursor;
  # nixpkgs.config.allowUnfree = true;
  programs.vscode.profiles.default = {
    # package = utils.functions.mkIfLinux pkgs.vscode;
    extensions = with pkgs.vscode-marketplace; [
      # copilot
      github.copilot
      github.copilot-chat

      # remote development
      ms-vscode-remote.vscode-remote-extensionpack
      # catppuccin
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      zhuangtongfa.material-theme

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
      bradlc.vscode-tailwindcss
      
      # Misc
      redhat.vscode-yaml
      prisma.prisma
      ms-azuretools.vscode-docker
      editorconfig.editorconfig
      github.vscode-github-actions
      # Neovim Mode
      asvetliakov.vscode-neovim

      # graphql
      graphql.vscode-graphql
      graphql.vscode-graphql-syntax
    ];
    userSettings = {
      "workbench.colorTheme" = "One Dark Pro Mix";
      "workbench.iconTheme" = "catppuccin-mocha";
      "files.autoSave" = "onFocusChange";
      
      # tab stop by language
      "[typescriptreact]" = mkFrontendSettings 2;
      "[javascript]" = mkFrontendSettings 2;
      "[typescript]" = mkFrontendSettings 2;
      "[javascriptreact]" = mkFrontendSettings 2;
      "[css]" = mkFrontendSettings 2;
      "[less]" = mkFrontendSettings 2;
      "[html]" = mkFrontendSettings 2;
      "[json]" = mkFrontendSettings 2;

      "extensions.experimental.affinity" = {
        "asvetliakov.vscode-neovim" = 1;
      };
    } // editorSettings // terminalSettings;
  };
  # home.activation.copyVscodeSettingsToCursor = lib.hm.dag.entryAfter ["writeBoundary" "installPackages"] ''
  #   rm -rf "${cursorExtensionsDir}"
  #
  #   mkdir -p "${cursorConfigDir}"
  #   mkdir -p "${cursorExtensionsDir}"
  #
  #   if [ -d "${vscodeConfigDir}" ] && [ -d "${cursorConfigDir}" ]; then
  #     if [ -f "${vscodeConfigDir}"/settings.json ]; then
  #       ln -sf "${vscodeConfigDir}"/settings.json "${cursorConfigDir}"/settings.json
  #     fi
  #     if [ -f "${vscodeConfigDir}"/tasks.json ]; then
  #       ln -sf "${vscodeConfigDir}"/tasks.json "${cursorConfigDir}"/tasks.json
  #     fi
  #     if [ -d "${vscodeConfigDir}"/snippets ]; then
  #       ln -sf "${vscodeConfigDir}"/snippets "${cursorConfigDir}"
  #     fi
  #   fi
  #
  #   if [ -d "${vscodeExtensionsDir}" ] && [ -d "${cursorExtensionsDir}" ]; then
  #     cp -r "${vscodeExtensionsDir}"/* "${cursorExtensionsDir}"
  #     sed -i 's/\/\.vscode/\/\.cursor/g' ${cursorExtensionsDir}/extensions.json
  #   fi
  # '';
}
