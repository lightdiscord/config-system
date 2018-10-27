{ config, ... }:

let

	home-manager = https://github.com/rycee/home-manager/archive/master.tar.gz;

in {

	imports = [
		"${(fetchTarball home-manager)}/nixos"
	];

	home-manager.users.arnaud = import ./home-manager {
		sysconfig = config;
	};

}
