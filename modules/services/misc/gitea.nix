{ config, lib, pkgs, ... }:

with lib;

let
	name = "gitea";
	address = "127.0.5.1";

	cfg = config.alphabet.services.gitea;
	caddy = config.alphabet.services.caddy;
	gitea = config.services.gitea;
in {
	options.alphabet.services.gitea = {
		enable = mkEnableOption "Gitea service";
	};

	config = mkIf cfg.enable {
		services.gitea = {
			enable = true;
			appName = "Gitea";
			httpAddress = address;
			rootUrl = mkIf caddy.enable "http://${name}/";
			extraConfig = ''
				[ui]
				DEFAULT_THEME=arc-green
			'';
		};

		networking.hosts.${address} = [
			name
		];

		alphabet.services.caddy.sections = [
			''
				http://${name} {
					proxy / ${address}:${toString gitea.httpPort}
				}
			''
		];
	};
}
