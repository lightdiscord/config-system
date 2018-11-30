{ config, lib, pkgs, ... }:

with lib;

{
	home-manager.users.arnaud = {
		xsession.windowManager.awesome.noArgb = mkForce true;
		services.compton.enable = mkForce false;
	};
}
