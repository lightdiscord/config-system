{ config, lib, pkgs, ... }:

let
  stateVersion = "18.03";
  hostName = "nixos";

  country = "fr";
  credentials = /etc/keys/protonvpn.txt;
in {

  imports = [
    ../options/protonvpn/protonvpn-nm.nix

    ./users/arnaud.nix
  ];

  system = {
    inherit stateVersion;
  };

  nixpkgs.config.allowUnfree = true;

  i18n = {
    #consoleFont = "sun12x14";
    consoleKeyMap = "fr";
    defaultLocale = "en_US.UTF-8";
  };

  networking = {
    networkmanager = {
      enable = true;
      protonvpn = {
        enable = true;

        inherit country credentials;
      };
    };

    inherit hostName;
  };

  time.timeZone = "Europe/Paris";

  environment.systemPackages = with pkgs; [
    tmux neovim alacritty
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
