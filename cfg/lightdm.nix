{ config, libs, pkgs, ... }:

{

  imports = [
    ./video.nix
  ];

  services.xserver = {
    enable = true;
    layout = "fr";
    displayManager.lightdm.enable = true;
  };
}