{ config, lib, pkgs, ... }:

with lib;

let
	name = "gitea";
	address = "127.0.5.1";

	cfg = config.lambda.services.gitea;
	caddy = config.lambda.services.caddy;
	gitea = config.services.gitea;
in {
	options.lambda.services.gitea = {
		enable = mkEnableOption "Gitea service";
	};

	config = mkIf cfg.enable {
		services.gitea = {
			enable = true;
			appName = "Lambda";
			httpAddress = address;
			rootUrl = mkIf caddy.enable "https://${name}/";
			extraConfig = ''
				[ui]
				DEFAULT_THEME=arc-green
			'';
		};

		networking.hosts.${address} = [
			name
		];

		lambda.services.caddy.sections = [
			''
				http://${name} {
					proxy / ${address}:${toString gitea.httpPort}
				}
			''
		];
	};
}
