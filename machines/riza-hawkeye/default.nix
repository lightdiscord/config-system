{ config, lib, pkgs, ... }:

with lib;

let

	# Animes can also be watch in VF.
	layout = "fr";

	root = "/dev/disk/by-uuid/e1a4de53-cdfb-45fa-a266-f9325d6ae48a";
	boot = "/dev/disk/by-uuid/AA1A-5E09";
	datas = "/dev/disk/by-label/datas";
	swap = "/dev/disk/by-label/swap";

in {
	imports = [
		<nixpkgs/nixos/modules/installer/scan/not-detected.nix>
	];

	nix.maxJobs = mkDefault 8;

	powerManagement.cpuFreqGovernor = mkDefault "powersave";

	fileSystems = {
		"/" = {
			device = root;
			fsType = "ext4";
		};

		"/boot" = {
			device = boot;
			fsType = "vfat";
		};

		"/datas" = {
			device = datas;
			fsType = "ext4";
		};
	};

	swapDevices = [
		{ device = swap; }
	];

	hardware.nvidia.modesetting.enable = true;

	services.xserver = mkIf config.services.xserver.enable {
		videoDrivers = ["nvidia"];

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

		inherit layout;
	};

	i18n.consoleKeyMap = layout;

	hardware.sane.brscan4.netDevices = {
		home = { model = "DCP-L2540DN"; ip = "192.168.1.210"; };
	};

	services.printing.drivers = with pkgs; [ gutenprintBin brlaser hplip ];
}
