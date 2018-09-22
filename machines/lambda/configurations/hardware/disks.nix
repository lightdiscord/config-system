{ ... }:

let
	root = "/dev/disk/by-uuid/e1a4de53-cdfb-45fa-a266-f9325d6ae48a";
	boot = "/dev/disk/by-uuid/AA1A-5E09";
	data = "/dev/disk/by-uuid/cfe50193-7b93-4402-960a-483b740545d9";
	home = "/dev/disk/by-uuid/d8bea3d8-ca43-4c5e-b1cf-f06e4dbded0d";
	swap = "/dev/disk/by-uuid/6d587ddc-69e7-49e4-82d0-ba73760de399";
in {
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
			device = data;
			fsType = "ext4";
		};

		"/home" = {
			device = home;
			fsType = "ext4";
		};

		"/home/arnaud/Documents" = {
			device = data;
			fsType = "ext4";
		};
	};

	swapDevices = [
		{ device = swap; }
	];
}
