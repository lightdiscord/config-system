{ ... }:

{
	imports = [
		<nixpkgs/nixos/modules/services/hardware/sane_extra_backends/brscan4.nix>
	];

	hardware.sane.enable = true;
	hardware.sane.brscan4 = {
		enable = true;
		netDevices = {
			home = { model = "DCP-L2540DN"; ip = "192.168.1.210"; };
		};
	};
}
