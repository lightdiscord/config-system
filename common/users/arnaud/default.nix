{ config, lib, pkgs, ... }:

let
	data = import ./data.nix;

	hashedPassword = "$6$LRS6oz74Lt0$wxRJrD9dVK61ofjP9Cwc1ymNz6l8oknWUHx71pYqtkEY1KfeDdSU3bnslGO8A7TeM1AXYh8.p57IQ8wbVQvBO0";

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

	programs.fish.enable = true;
}
