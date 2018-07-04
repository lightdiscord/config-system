{ config, lib, pkgs, ... }:

with lib;

let
	cfg = config.lambda.programs.gnome-keyring;

	lightdm = config.lambda.hardware.video.lightdm;
in {
	options.lambda.programs.gnome-keyring = {
		enable = mkEnableOption "Gnome Keyring";
	};

	config = mkIf cfg.enable {
  	services.gnome3.gnome-keyring.enable = true;

		security.pam.services.lightdm.enableGnomeKeyring = lightdm.enable;
	};
}
