{ ... }:

{
	services.xserver = {
		enable = true;

		layout = "fr";

		xrandrHeads = [
			{ output = "DP-1"; primary = true; }
			{ output = "HDMI-0"; monitorConfig = "Option \"Rotate\" \"right\""; }
		];

		screenSection = ''
			Option "metamodes" "HDMI-0: nvidia-auto-select +1920+0 {rotation=right}, DP-1: nvidia-auto-select +0+0"
		'';

		resolutions = [
			{ x = 1920; y = 1080; }
		];

		dpi = 80;
	};
}
