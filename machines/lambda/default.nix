{ config, pkgs, ... }:

{
	imports = (import ../../modules) ++ (import ./configurations) ++ [
		../../common/users/arnaud
	];

	alphabet.letter = "Lambda";

	alphabet.security.yubikey.enable = true;
	alphabet.programs.gnome-keyring.enable = true;
	alphabet.services.gitea.enable = true;
	alphabet.services.caddy.enable = true;

	system.stateVersion = "18.09";

	time.timeZone = "Europe/Paris";

	fonts.fonts = with pkgs; [
		fira-code
	];

	services.tor = {
		enable = true;
		client.enable = true;
	};

	services.openssh.enable = true;

	i18n = {
		consoleKeyMap = "fr";
		defaultLocale = "en_US.UTF-8";
	};

	networking = {
		networkmanager.enable = true;
		hostName = config.alphabet.letter;
	};

	nix.useSandbox = true;
	nixpkgs.config.allowUnfree = true;

	services.openvpn.providers.protonvpn = {
		enable = true;
		country = "fr";
		credentials = /etc/keys/protonvpn.txt;
	};

	environment.systemPackages = with pkgs; [
		neovim tmux alacritty
	];

	virtualisation.docker.enable = true;
	virtualisation.virtualbox.host.enable = true;
}
