{ config, lib, pkgs, ... }:

# Credits: @DeltaEvo/nixos-configs/machines/omega.nix

with lib;

let

	layout = "fr";

in {
	imports = [
		/home/arnaud/Workspaces/nixos-channel-debug/lol.nix
		# <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
		# (builtins.fetchurl https://raw.githubusercontent.com/matthewbauer/nixpkgs/f05d8f31ec944eb5b07a9dbf80b606372e47cb21/nixos/modules/installer/cd-dvd/channel.nix)
		# (builtins.fetchurl https://raw.githubusercontent.com/NixOS/nixpkgs/ba3af439ecaab9dedbace04b29860ddedb2b433d/nixos/modules/installer/cd-dvd/channel.nix)
		<nixpkgs/nixos/modules/installer/cd-dvd/iso-image.nix>
		# <nixpkgs/nixos/modules/installer/cd-dvd/sd-image-armv7l-multiplatform.nix>
		<nixpkgs/nixos/modules/installer/scan/detected.nix>
		<nixpkgs/nixos/modules/installer/scan/not-detected.nix>
		<nixpkgs/nixos/modules/profiles/all-hardware.nix>
	];

	isoImage = rec {
		isoName = "${volumeID}-${pkgs.stdenv.hostPlatform.system}.iso";
		volumeID = config.networking.hostName;
		makeEfiBootable = true;#(builtins.trace (readFile <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>) true);
		makeUsbBootable = true;
	};

	# sdImage = {
	# 	imageName = "${volumeID}
	# }

	boot.loader.grub.memtest86.enable = true;
	boot.supportedFilesystems = [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" ];

	services.xserver = mkIf config.services.xserver.enable {
		libinput.enable = true;
		inherit layout;
	};

	i18n.consoleKeyMap = layout;
}
