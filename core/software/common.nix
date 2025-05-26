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
      openssh
      fzf
      uv
      unzip

      # aws
      awscli2
      aws-gate
      terraform

      # Development
      nodejs_20
      bun
      yarn
      pnpm
      stow
      ngrok
      twilio-cli
      pythonWithPackages

      #c Rust
      cargo
      _1password-cli
      
    ];
}
