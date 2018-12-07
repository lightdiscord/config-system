{ config, lib, pkgs, ... }:

with lib;

let
	ucm = fetchGit {
		url = "git@github.com:plbossart/UCM.git";
		rev = "2050ca78a4d1a853d1ba050b591f42e6f97adfc0";
	};
in {
	home-manager.users.arnaud = {
		xsession.windowManager.awesome.noArgb = mkForce true;
		services.compton.enable = mkForce false;
	};

	boot.kernelParams = [ "acpi_backlight=vendor" ];

	system.replaceRuntimeDependencies = [{
		original = pkgs.alsaLib;

		replacement = pkgs.alsaLib.overrideAttrs (super: {
			postFixup = "cp -r ${ucm}/chtmax98090 $out/share/alsa/ucm";
		});
	}];
}
