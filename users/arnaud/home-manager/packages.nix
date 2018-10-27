{ sysconfig }: { lib, pkgs, ... }:

with lib;

let
	neovim = ../../../packages/neovim;

	packages = with pkgs; ([
		psmisc
		tmate
		gcc
		gnumake
		rustup
		neomutt
		htop
		bat
		taskwarrior
		pinentry
		neomutt
		protonmail-bridge
		ponysay
		(callPackage neovim {})
	] ++ optionals sysconfig.services.xserver.enable [
		discord
		pavucontrol
		google-chrome
		feh
		vscode
		xsel
		xclip
		shutter
		thunderbird
		kitty
		libreoffice
	]);

in {
	home.packages = packages;
}

