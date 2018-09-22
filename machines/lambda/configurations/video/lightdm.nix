{ pkgs, ... }:

let
	background = {
		url = https://wallpapers.wallhaven.cc/wallpapers/full/wallhaven-656580.png;
		sha256 = "0pqxwsgyjvs7pnqnqlm3d7vw21xikw4j046l82gj6mlpg3w4fdrn";
	};
in {
	alphabet.hardware.video.lightdm = {
		enable = true;
		background = toString (pkgs.fetchurl background);
	};
}
