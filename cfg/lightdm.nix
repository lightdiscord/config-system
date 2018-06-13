{ config, libs, pkgs, ... }:

let 
  enable = true;

  background = pkgs.fetchurl {
      name = "wallpaper.png";
      url = "https://images2.alphacoders.com/697/697173.jpg";
      sha256 = "0vy3rzwm395n2jk939lmcwlpm5zri8dyrs455m9rr77h40gq80wc";
  };
in {

  imports = [
    ./video.nix
  ];

  security.pam.services.lightdm.enableGnomeKeyring = true;

  services.xserver = {
    layout = "fr";
    displayManager.lightdm = {
      background = toString background;
      inherit enable;
    };

    inherit enable;
  };
}
