{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.lambda.services.caddy;
in {
  options.lambda.services.caddy = {
    enable = mkEnableOption "Caddy web server";

    sections = mkOption {
      default = [];
      example = [
        ''
          example.com {
            gzip
            minify
            log syslog
            root /srv/http
          }
        ''
      ];
      type = types.listOf types.lines;
      description = "Configuration sections";
    };
  };

    config = mkIf cfg.enable {
      services.caddy.enable = true;

      services.caddy.config = concatStringsSep "\n" cfg.sections;
    };
}
