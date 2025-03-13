{... }: 
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = null;
      UseDns = true;
      X11Forwarding = true;
      PermitRootLogin = "no";
    };
  };
  users.users.aris.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGrryp7PoutwQ7moP0fo7KQ16APYd3YYtGXUL8BGk7tW"
  ];
}
