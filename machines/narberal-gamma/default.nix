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

	boot.initrd.kernelModules = [
		"snd-seq"
		"snd-rawmidi"
		"i915"
	];

	boot.extraModprobeConfig = ''
		options snd slots=snd_soc_sst_bdw_rt5677_mach,snd-hda-intel
	'';

	hardware.enableAllFirmware = true;

	system.replaceRuntimeDependencies = [{
		original = pkgs.alsaLib;

		replacement = pkgs.alsaLib.overrideAttrs (super: {
			postFixup = "cp -r ${ucm}/chtmax98090 $out/share/alsa/ucm";
		});
	}];

	powerManagement = {
		enable = true;
		cpuFreqGovernor = "ondemand";
	};

	services.logind.extraConfig = ''
		HandlePowerKey=ignore
	'';

	hardware.pulseaudio.package = pkgs.pulseaudio.override {
		jackaudioSupport = true;
	};
}
