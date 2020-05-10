{ config, lib, pkgs, ... }:

{
	imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
	];

	boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
	boot.initrd.kernelModules = [ ];
	boot.kernelModules = [ "kvm-intel" ];
	boot.extraModulePackages = [ ];
	boot.blacklistedKernelModules = [ "dell_smbios" "i2c_nvidia_gpu" ];

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

	nix.maxJobs = lib.mkDefault 12;
	powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
