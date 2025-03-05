{ ... }:
{
  # nixos specific programs
  programs.firefox.enable = true;
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["aris"];
  };

  # programs 
  programs.zsh.enable = true;

  # deconf
  programs.dconf.enable = true;

  # nix-ld
  programs.nix-ld.enable = true;
}
