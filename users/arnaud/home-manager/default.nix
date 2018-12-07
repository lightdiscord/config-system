{ config, lib, pkgs, ... }:

with lib;

let

	awesome = if (builtins.tryEval <awesome>).success then <awesome> else fetchGit {
		url = "git@github.com:LightDiscord/Awesome";
		rev = "e175d73cb1f0584977bc3d2c5aebf690196c6814";
	};

in {
	imports = [
		(import ./packages.nix)
		(import awesome).home-manager
	];

	xsession.windowManager.awesome.enable = config.xsession.enable;

	nixpkgs.config.allowUnfree = true;

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

	programs.git = let user = import ../../../users/arnaud/data.nix; in {
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
}
