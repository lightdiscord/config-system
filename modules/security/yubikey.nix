{ config, lib, pkgs, ... }:

with lib;

let
	cfg = config.alphabet.security.yubikey;
in {
	options.alphabet.security.yubikey = {
		enable = mkEnableOption "Yubikey";
	};

	config = mkIf cfg.enable {
		environment.systemPackages = with pkgs; [
			opensc
			gnupg
			pcsctools
			yubikey-personalization
		];

		services.pcscd.enable = true;

		services.udev.packages = with pkgs; [
			yubikey-personalization
		];

		programs.ssh.startAgent = false;

		programs.gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};
	};
}
