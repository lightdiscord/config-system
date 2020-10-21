{ flake-inputs, lib, ... }:

with lib;

{
  require = [
    flake-inputs.nixpkgs.nixosModules.notDetected
    flake-inputs.nixos-hardware.nixosModules.common-cpu-intel
    flake-inputs.nixos-hardware.nixosModules.common-pc-laptop
    flake-inputs.nixos-hardware.nixosModules.common-gpu-nvidia
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" "sr_mod" "rtsx_pci_sdmmc"
  ];

  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.blacklistedKernelModules = [ "dell_smbios"  "i2c_nvidia_gpu" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/8074308b-f567-4a76-ae17-0faee1fbf5b7";
    fsType = "ext4";
  };

  fileSystems."/boot" =	{
    device = "/dev/disk/by-uuid/4DFD-B9C1";
    fsType = "vfat";
  };

  fileSystems."/mnt/datas" = {
    device = "/dev/disk/by-uuid/db471248-79bc-4b8b-bc1a-77adbe79cb68";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  swapDevices = [ ];

  nix.maxJobs = mkDefault 12;
  powerManagement.cpuFreqGovernor = mkDefault "powersave";

  hardware.nvidia = {
#    modesetting.enable = true;
    prime = {
#      sync.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };
  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
}
