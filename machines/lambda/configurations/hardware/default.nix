{ lib, ... }:

with lib;

{
	imports = [
		<nixpkgs/nixos/modules/installer/scan/not-detected.nix>
		./disks.nix
	];

	nix.maxJobs = mkDefault 8;
	powerManagement.cpuFreqGovernor = mkDefault "powersave";
}
