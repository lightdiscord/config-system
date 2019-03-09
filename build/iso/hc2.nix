(import <nixpkgs/nixos/lib/eval-config.nix> {
	system = "armv7l-linux";

	modules = let

		machines = import ../../machines;
		systems = import ../../systems;

	in [
		machines.sakamoto
		({...}: {
			nixpkgs.system = "armv7l-linux";
		})
	];
}).config.system.build.sdImage
