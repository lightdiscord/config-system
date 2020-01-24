{ config, pkgs, ... }:

let
	# nixpkgs-mozilla = import (pkgs.fetchFromGitHub {
	# 	owner = "mozilla";
	# 	repo = "nixpkgs-mozilla";
	# 	rev = "9d08acc6e95a784cf7b9ba73ebcabe86dd24abc0";
	# 	sha256 = "01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b";
	# });
	nixpkgs-mozilla = import (builtins.fetchTarball {
		url = https://github.com/mozilla/nixpkgs-mozilla/archive/9d08acc6e95a784cf7b9ba73ebcabe86dd24abc0.tar.gz;
		sha256 = "1vr0crlfba2y2phar7rn4xyyh7m4v3i5lvvy9z1hgwdjx5ch2dfi";
	});
in {
	require = [
		./hardware-configuration.nix
		/mnt/datas/gits/lightdiscord/home-arnaud
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	boot.kernelPackages = pkgs.linuxPackages_latest;
	boot.extraModulePackages = with config.boot.kernelPackages; [ exfat-nofuse ];

	boot.cleanTmpDir = true;

	networking.hostName = "ritsu";

	networking.useDHCP = false;
	networking.interfaces.enp69s0.useDHCP = true;
	# networking.interfaces.enp0s20f0u2u5u4.useDHCP = true;

	i18n = {
		consoleKeyMap = "fr";
		defaultLocale = "en_US.UTF-8";
	};

	time.timeZone = "Europe/Paris";

	environment.systemPackages = with pkgs; [
		vim
	];

	sound.enable = true;
	hardware.pulseaudio = {
		enable = true;
		support32Bit = true;
	};

	services.xserver = {
		enable = true;
		layout = "fr";
		videoDrivers = [ "nvidia" ];

		displayManager = {
			lightdm.enable = true;
			sessionCommands = ''
				${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-0 --left-of eDP-1-1 --output eDP-1-1 --primary
			'';
		};
		windowManager.i3.enable = true;
		libinput.enable = true;
	};

	services.compton.enable = true;


	hardware.nvidia.optimus_prime = {
		enable = true;
		nvidiaBusId = "PCI:1:0:0";
		intelBusId = "PCI:0:2:0";
	};

	hardware.nvidia.modesetting.enable = true;

	hardware.opengl = {
		enable = true;
		driSupport32Bit = true;
	};

	networking.networkmanager.enable = true;

	users.groups."plugdev" = {};

	users.users.arnaud = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" "plugdev"];
		packages = [ pkgs.steam pkgs.google-chrome ((pkgs.rustChannelOf { date = "2020-01-22"; channel = "nightly";
	}).rust.override {
		extensions = ["rls-preview" "rust-analysis" "rust-src"];
	})
		(pkgs.callPackage /mnt/datas/gits/lightdiscord/emacs {})
		pkgs.qgnomeplatform ];
	};

	services.pcscd.enable = true;

	services.udev.packages = with pkgs; [ yubikey-personalization libu2f-host ];

	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
	};

	nixpkgs.config.allowUnfree = true;
	nixpkgs.overlays = [ nixpkgs-mozilla ];

	services.redshift.enable = true;

	location = {
		latitude = 48.85341;
		longitude = 2.3488;
	};

	hardware.firmware = [
		(pkgs.callPackage ./firmwares/rtl8125a-3-fw.nix { })
	];

	# qt5 = {
	# 	enable = true;
	# 	platformTheme = "gnome";
	# 	style = "adwaita";
	# };


	# This value determines the NixOS release with which your system is to be
	# compatible, in order to avoid breaking some software such as database
	# servers. You should change this only after NixOS release notes say you
	# should.
	system.stateVersion = "19.09";
}
