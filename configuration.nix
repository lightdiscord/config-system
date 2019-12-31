{ config, pkgs, ... }:

{
	imports = [
		./hardware-configuration.nix
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	boot.kernelPackages = pkgs.linuxPackages_latest;
	boot.extraModulePackages = with config.boot.kernelPackages; [ exfat-nofuse ];

	boot.cleanTmpDir = true;

	networking.hostName = "ritsu";

	networking.useDHCP = false;
	networking.interfaces.enp69s0.useDHCP = true;

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

		displayManager.lightdm.enable = true;
		windowManager.i3.enable = true;
		libinput.enable = true;
	};


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

	users.users.arnaud = {
		isNormalUser = true;
		extraGroups = [ "wheel" ];
		packages = [ pkgs.steam ];
	};

	services.pcscd.enable = true;

	services.udev.packages = with pkgs; [ yubikey-personalization libu2f-host ];

	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
	};

	nixpkgs.config.allowUnfree = true;

	# This value determines the NixOS release with which your system is to be
	# compatible, in order to avoid breaking some software such as database
	# servers. You should change this only after NixOS release notes say you
	# should.
	system.stateVersion = "19.09";
}
