{ pkgs, ... }:

{
	services.mopidy = {
		enable = true;
		extensionPackages = [ pkgs.mopidy-gmusic ];
		configuration = import /home/arnaud/.config/mopidy/configuration.nix;
	};
}
