{ config, pkgs, ... }:

{
  imports = [
    ../hardware-configuration.nix

    ../cfg/base.nix
    ../cfg/lightdm.nix
    ../cfg/yubikey.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.printing.enable = true;

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    neovim
  ];
}