{ pkgs, lib, utilities, ... }:
let
  opSignSshProgram = if utilities.constants.isDarwin
    then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
    else "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
in 
{
  home.packages = with pkgs; [
    git
    git-lfs
    git-credential-manager
  ];

  programs.git = {
    enable = true;
    package = pkgs.git;
    userName = "Alex Zhang";
    userEmail = "zhangchi0104@live.com";
    extraConfig = {
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = {
        program = opSignSshProgram;
      };
      commit = {
        gpgSign = true;
      };
      user = {
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII5aUuGYFLpnAGQZh+r2Aa5O1ZT6jN4QH6MwvPrFnWTp";
      };
    };
  };
}
