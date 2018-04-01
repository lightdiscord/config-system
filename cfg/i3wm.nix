{ config, libs, pkgs, ... }:

let
  package = pkgs.i3-gaps;
in {

  imports = [
    ./video.nix
  ];

  services.xserver = {
    enable = true;
    layout = "fr";
    displayManager.lightdm.enable = true;
    windowManager.i3 = {
      enable = true;
      inherit package;
    };
  };
}