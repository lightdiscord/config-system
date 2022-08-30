{ config, lib, ... }:

{
  # TODO: Enable docker prune on items older than a week or month?

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  users.users.user.extraGroups = lib.optional config.virtualisation.docker.enable "docker";
}
