{ config, pkgs, ... }:

{
	imports = (import ../../modules) ++ [
		./hardware-configuration.nix
		../../common/users/arnaud

		<nixpkgs/nixos/modules/services/hardware/sane_extra_backends/brscan4.nix>
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.cleanTmpDir = true;
	boot.kernelPackages = pkgs.linuxPackages_latest;

	virtualisation.docker.enable = true;
	virtualisation.virtualbox.host.enable = true;

	services.tor = {
		enable = true;
		client.enable = true;
	};

	services.openssh.enable = true;

	hardware.sane.enable = true;
	hardware.sane.brscan4 = {
		enable = true;
		netDevices = {
			home = { model = "DCP-L2540DN"; ip = "192.168.1.210"; };
		};
	};

	i18n = {
		consoleKeyMap = "fr";
		defaultLocale = "en_US.UTF-8";
	};

	hardware.pulseaudio = {
		enable = true;
		support32Bit = true;
		tcp = {
			enable = true;
			anonymousClients.allowedIpRanges = ["127.0.0.1"];
		};
	};

	services.mopidy = {
		enable = true;
		extensionPackages = [ pkgs.mopidy-gmusic ];
		configuration = import /home/arnaud/.config/mopidy/configuration.nix;
	};

	nix.useSandbox = true;
	nixpkgs.config.allowUnfree = true;

	lambda.programs.gnome-keyring.enable = true;

	services.xserver.enable = true;

	lambda.hardware.video.lightdm = {
		enable = true;
		background = toString (pkgs.fetchurl {
			url = "https://wallpapers.wallhaven.cc/wallpapers/full/wallhaven-656580.png";
			sha256 = "0pqxwsgyjvs7pnqnqlm3d7vw21xikw4j046l82gj6mlpg3w4fdrn";
		});
	};

	lambda.security.yubikey.enable = true;

	services.openvpn.providers.protonvpn = {
		enable = true;
		country = "fr";
		credentials = /etc/keys/protonvpn.txt;
	};

	time.timeZone = "Europe/Paris";

	environment.systemPackages = with pkgs; [
		neovim tmux alacritty
	];

	lambda.config.networking.enable = true;

	lambda.services.gitea.enable = true;
	lambda.services.caddy.enable = true;

	system.stateVersion = "18.09";
}
