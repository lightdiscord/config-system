{ pkgs, ... }:

{
	boot = {
		loader.systemd-boot.enable = true;
		loader.efi.canTouchEfiVariables = true;

		cleanTmpDir = true;

		kernelPackages = pkgs.linuxPackages_latest;

		initrd.availableKernelModules = [
			"xhci_pci"
			"ehci_pci"
			"ahci"
			"usbhid"
			"usb_storage"
			"sd_mod"
			"sr_mod"
		];

		kernelModules = ["kvm-intel"];

		extraModulePackages = [];
	};
}
