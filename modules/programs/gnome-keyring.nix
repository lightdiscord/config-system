{ config, lib, pkgs, ... }:

with lib;

let
	cfg = config.alphabet.programs.gnome-keyring;

	lightdm = config.alphabet.hardware.video.lightdm;
in {
	options.alphabet.programs.gnome-keyring = {
		enable = mkEnableOption "Gnome Keyring";
	};

	config = mkIf cfg.enable {
		services.gnome3.gnome-keyring.enable = true;

		security.pam.services.lightdm.enableGnomeKeyring = lightdm.enable;
	};
}
