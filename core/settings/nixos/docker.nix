{ ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    storageDriver = "btrfs";
    rootless.enable = true;
    rootless.setSocketVariable = true;
  };
  hardware.nvidia-container-toolkit.enable = true;
  users.users.aris.extraGroups = [ "docker" ];
}
