{ pkgs, ... }:

let

	machines = import ./machines;
	systems = import ./systems;

in {
	imports = [
		# Change to the machine you want.
		machines.riza-hawkeye

		# Change to the system you want.
		systems.lambda
	];

	services.glusterfs.enable = true;
	system.fsPackages = [
		pkgs.glusterfs
	];

	hardware.bluetooth.enable = true;

	fonts.fonts = with pkgs; [
		lato
		roboto
	];

	nix.trustedUsers = ["arnaud"];

	boot.loader.grub.useOSProber = true;

	environment.systemPackages = [
		pkgs.steam
		(pkgs.wine.override { wineBuild = "wineWow"; netapiSupport = true; })
	];

	hardware.opengl.driSupport32Bit = true;
	hardware.pulseaudio.support32Bit = true;
}
