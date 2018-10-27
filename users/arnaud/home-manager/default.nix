{ sysconfig }: { config, lib, pkgs, ... }:

with lib;

let
	xserver = sysconfig.services.xserver.enable;
in {

	imports = ([
		(import ./packages.nix { inherit sysconfig; })
	] ++ optionals xserver [
		(import ./modules/awesome).home-manager
	]);

	nixpkgs.config.allowUnfree = true;

	home.keyboard.layout = sysconfig.i18n.consoleKeyMap;

	manual.manpages.enable = true;

	services.gnome-keyring = {
		enable = true;
		components = ["secrets" "pkcs11" "ssh"];
	};

	services.compton.enable = config.xsession.enable;

	services.redshift = {
		inherit (config.xsession) enable;

		latitude = "43.643116";
		longitude = "6.875682";
	};

	programs.git = let
		user = import ../../../users/arnaud/data.nix;
	in {
		enable = true;

		signing = {
			signByDefault = true;
			key = user.keys.gpg;
		};

		userEmail = user.email;
		userName = user.nickname;

		extraConfig = ''
			[core]
			editor=code --wait
		'';
	};

	services.gpg-agent = {
		enable = true;
		enableSshSupport = true;
		defaultCacheTtl = 60;
	};

	xsession.enable = xserver;
}
