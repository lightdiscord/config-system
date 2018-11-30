{ config, lib, pkgs, ... }:

# Credits: @DeltaEvo/nixos-configs/machines/omega.nix

with lib;

let

	layout = "fr";

in {
	imports = [
		# <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
		<nixpkgs/nixos/modules/installer/cd-dvd/iso-image.nix>
		<nixpkgs/nixos/modules/installer/scan/detected.nix>
		<nixpkgs/nixos/modules/installer/scan/not-detected.nix>
		<nixpkgs/nixos/modules/profiles/all-hardware.nix>
	];

	isoImage = rec {
		isoName = "${volumeID}-${pkgs.stdenv.hostPlatform.system}.iso";
		volumeID = config.networking.hostName;
		makeEfiBootable = true;
		makeUsbBootable = true;
	};

	boot.loader.grub.memtest86.enable = true;
	boot.supportedFilesystems = [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" ];

	services.xserver = mkIf config.services.xserver.enable {
		libinput.enable = true;
		inherit layout;
	};

	i18n.consoleKeyMap = layout;
}
