{ config, lib, pkgs, ... }:

with lib;

let
	cfg = config.alphabet.hardware.video.nvidia;
in {
	options.alphabet.hardware.video.nvidia = {
		enable = mkEnableOption "Nvidia video driver";
	};

	config = mkIf cfg.enable {
		services.xserver.videoDrivers = ["nvidia"];
	};
}
