{ config, lib, pkgs, ... }:

let
	data = import ./data.nix;

	hashedPassword = "$6$e566i4mefg$5CYIo322waMvcRXNAVITrBYZsK8T4JDwe5OQAAV1KMC4akxW5f/fO9PgWDGLxhD15X5YVIrWD/lqXGcZ1zYJY1";

	extraGroups = [
		"wheel"
		"networkmanager"
		"audio"
		"git"
		"docker"
		"vboxusers"
		"scanner"
		"lp"
	];
in {
	users.extraUsers.arnaud = {
		uid = 1000;
		isNormalUser = true;
		createHome = true;
		description = data.nickname;

		openssh.authorizedKeys.keys = [ data.keys.ssh ];

		shell = pkgs.fish;

		inherit hashedPassword extraGroups;
	};

	programs.fish.enable = config.users.extraUsers.arnaud.shell == pkgs.fish;
}
