{ config, lib, pkgs, ... }:

with lib;

let
	cfg = config.lambda.config.networking;
in {
	options.lambda.config.networking = {
		enable = mkEnableOption "Networking";
	};

	config = mkIf cfg.enable {
		networking.networkmanager.enable = true;
		networking.hostName = "Lambda";
	};
}
