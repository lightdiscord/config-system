{ config, lib, pkgs, ... }:

with lib;

let
	home-manager = fetchGit {
		url = "git@github.com:rycee/home-manager.git";
		rev = "40b279e3a33fd47b7e65e0303fcb9be621aeb7d3";
	};
in {
	imports = [(import home-manager {}).nixos];

	home-manager.users.arnaud = mkMerge [
		({
			xsession.enable = config.services.xserver.enable;
			home.keyboard.layout = config.i18n.consoleKeyMap;
		})

		(import ./home-manager)
  ];
}
