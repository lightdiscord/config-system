{ config, lib, pkgs, flake-inputs, ... }:

{
  require = [
    flake-inputs.nixpkgs.nixosModules.notDetected
    flake-inputs.nixos-hardware.nixosModules.common-cpu-amd
    flake-inputs.nixos-hardware.nixosModules.common-gpu-amd
  ];

  boot.initrd.availableKernelModules = [
    "nvme" "xhci_pci" "ahci" "uas" "usbhid" "usb_storage" "sd_mod"
  ];

  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" =	{
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
  };

  networking.useDHCP = lib.mkDefault true;
}
