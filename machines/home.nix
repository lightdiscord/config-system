{ config, pkgs, ... }:

{
  imports = [
    ../hardware-configuration.nix

    ../cfg/base.nix
    ../cfg/i3wm.nix
    ../cfg/yubikey.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
  ];
}