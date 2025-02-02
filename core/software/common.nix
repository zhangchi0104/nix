{ pkgs, ... }: 
{
  environment.systemPackages =  with pkgs; 
    let 
      pythonWithPackages = python3.withPackages(ps: [ps.pynvim ps.rich ps.pydantic]);
    in
    [
      # Editor
      vim
      neovim
      # Shells

      zsh
      # CLI tools
      git
      zellij
      btop
      bat
      lazygit
      starship
      zoxide
      wget
      curl
      ripgrep
      eza
 
      # Development
      nodejs_20
      bun
      yarn
      stow
      ngrok
      twilio-cli
      pythonWithPackages
      # darwin
      cocoapods
    ];
}
