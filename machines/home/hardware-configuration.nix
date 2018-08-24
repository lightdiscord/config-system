{ config, lib, pkgs, ... }:

{
	imports = (import ../../modules) ++ [
		<nixpkgs/nixos/modules/installer/scan/not-detected.nix>
	];

	boot.initrd.availableKernelModules = [
		"xhci_pci"
		"ehci_pci"
		"ahci"
		"usbhid"
		"usb_storage"
		"sd_mod"
		"sr_mod"
	];

	boot.kernelModules = ["kvm-intel"];
	boot.extraModulePackages = [];

	fileSystems = {
		"/" = {
			device = "/dev/disk/by-uuid/e1a4de53-cdfb-45fa-a266-f9325d6ae48a";
			fsType = "ext4";
		};

		"/boot" = {
			device = "/dev/disk/by-uuid/AA1A-5E09";
			fsType = "vfat";
		};

		"/datas" = {
			device = "/dev/disk/by-uuid/cfe50193-7b93-4402-960a-483b740545d9";
			fsType = "ext4";
		};

		"/home" = {
				device = "/dev/disk/by-uuid/d8bea3d8-ca43-4c5e-b1cf-f06e4dbded0d";
				fsType = "ext4";
			};
	};

	swapDevices = [
		{ device = "/dev/disk/by-uuid/6d587ddc-69e7-49e4-82d0-ba73760de399"; }
	];

	nix.maxJobs = lib.mkDefault 8;
	powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

	lambda.hardware.video.nvidia.enable = true;

	services.xserver = {
		layout = "fr";

		xrandrHeads = [
			{ output = "DP-1"; primary = true; }
			{ output = "HDMI-0"; monitorConfig = "Option \"Rotate\" \"right\""; }
		];

		screenSection = ''
			Option "metamodes" "HDMI-0: nvidia-auto-select +1920+0 {rotation=right}, DP-1: nvidia-auto-select +0+0"
		'';

		resolutions = [
			{ x = 1920; y = 1080; }
		];

		dpi = 80;
	};
}
