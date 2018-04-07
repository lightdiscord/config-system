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

  fileSystems."/datas" = {
    device = "/dev/disk/by-uuid/07a9c7c5-2511-4974-a9b0-d3591e7cdb4f";
    fsType = "ext4";
    options = [ "nofail" ];
  };
}