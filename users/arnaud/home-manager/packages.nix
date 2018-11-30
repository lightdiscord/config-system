{ config, lib, pkgs, ... }:

with lib;

let
	neovim = ../../../packages/neovim;
in {
	home.packages = with pkgs; ([
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
		upower
		acpi
	] ++ optionals config.xsession.enable [
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
}

