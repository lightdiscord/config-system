(import <nixpkgs/nixos/lib/eval-config.nix> {
	system = "x86_64-linux";

	modules = let

		machines = import ../../machines;
		systems = import ../../systems;

	in [
		machines.sakamoto
		systems.lambda
	];
}).config.system.build.isoImage
