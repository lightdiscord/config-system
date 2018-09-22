{ ... }:

{
	imports = [
		./xserver.nix
		./lightdm.nix
	];

	alphabet.hardware.video.nvidia.enable = true;
}
