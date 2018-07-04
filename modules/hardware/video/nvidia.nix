{ config, lib, pkgs, ... }:

with lib;

let
	cfg = config.lambda.hardware.video.nvidia;
in {
	options.lambda.hardware.video.nvidia = {
		enable = mkEnableOption "Nvidia video driver";
	};

	config = mkIf cfg.enable {
		services.xserver.videoDrivers = ["nvidia"];
	};
}
