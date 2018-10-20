{ config, ... }:

let

	home-manager = https://github.com/rycee/home-manager/archive/master.tar.gz;
	dotfiles = https://github.com/LightDiscord/Dotfiles/archive/master.tar.gz;

	nixpkgs = "${config.users.users.arnaud.home}/.config/nixpkgs";
	location = if builtins.pathExists nixpkgs then nixpkgs else dotfiles;

in {

	imports = [
		"${(fetchTarball home-manager)}/nixos"
	];

	home-manager.users.arnaud = import "${location}/home.nix";

}
