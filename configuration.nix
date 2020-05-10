{ lib, config, pkgs, ... }:

{
	require = [
		./hardware-configuration.nix
		./home-arnaud/nixos.nix
	];

	boot = {
		loader.systemd-boot.enable = true;
		loader.efi.canTouchEfiVariables = true;
		kernelPackages = pkgs.linuxPackages_latest;
		cleanTmpDir = true;
	};

	networking = {
		hostName = "ritsu";
		useNetworkd = true;
		useDHCP = false;
		wireless = {
			enable = true;
			userControlled.enable = true;
		};
	};

	systemd.network = {
		enable = true;
		# TODO: Systemd v245, we can use the Type match with ether or wlan.
		# https://github.com/systemd/systemd/pull/14957
		networks."40-ether" = {
			matchConfig.Name = "en*";
			DHCP = "yes";
		};

		networks."40-wlan" = {
			matchConfig.Name = "wl*";
			DHCP = "yes";
			linkConfig.RequiredForOnline = "no";
		};
	};

	services.upower.enable = true;

	console.keyMap = "fr";
	i18n.defaultLocale = "en_US.UTF-8";

	time.timeZone = "Europe/Paris";

	environment.systemPackages = with pkgs; [
		vim git
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
		libinput = {
			additionalOptions = ''MatchIsTouchpad "on"'';
			enable = true;
		};
		xkbVariant = "azerty";

		displayManager.lightdm = {
			enable = true;

			background = toString (pkgs.fetchurl {
				url = "https://cdna.artstation.com/p/assets/images/images/026/253/202/large/niyas-ck-red-test.jpg?1588281837";
				sha256 = "1gr9hxadis1368fbnxmwh6y4an7cmx1g0ryc14g5i2zxdd3ihmr1";
			});

			greeters.gtk.indicators = [ "~host" "~spacer" "~clock" "~spacer" "~session" "~language" "~ally" "~power" ];

			greeters.gtk.theme = {
				package = pkgs.arc-theme;
				name = "Arc-Dark";
			};
		};

		exportConfiguration = true;

		desktopManager.xterm.enable = true;

		xrandrHeads = [
			"HDMI-0"
			{ output = "eDP-1-1"; primary = true; }
			];

		# windowManager.i3 = {
		# 	enable = true;
		# 	extraPackages = with pkgs; [
		# 		feh
		# 		rofi
		# 		i3status
		# 		i3lock
		# 	];
		# };
		};

		programs.light.enable = true;

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

		users.groups."plugdev" = {};

		users.users.arnaud = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" "plugdev" "network" "video" "vboxusers" "docker" "libvirtd" ];
		shell = pkgs.fish;
		packages = [ pkgs.qgnomeplatform ];
		};

		boot.kernelModules = ["kvm-intel"];

		virtualisation.docker = {
		enable = true;
		enableOnBoot = false;
		};

		virtualisation.virtualbox.host.enable = true;

		services.pcscd.enable = true;

		services.udev.packages = with pkgs; [ yubikey-personalization libu2f-host ];

		programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
		};

		nixpkgs.config.allowUnfree = true;

		services.redshift.enable = true;

		location = {
		latitude = 48.85341;
		longitude = 2.3488;
		};

		hardware.firmware = [
		(pkgs.callPackage ./firmwares/rtl8125a-3-fw.nix { })
		];

	# virtualisation.virtualbox.host.enable = true;
	# users.groups.vboxusers.members = [ "arnaud" ];

	# systemd.user.services.randomize-background = let
	# 	wallpaper-folder = "/home/arnaud/Pictures/Wallpapers";
	# in {
	# 	description = "Run feh to randomize wallpapers";
	# 	requires = [ "graphical-session.target" ];
	# 	serviceConfig = {
	# 		Type = "oneshot";
	# 		ExecStart = "${pkgs.feh}/bin/feh --no-fehbg --bg-scale --randomize ${wallpaper-folder}";
	# 	};
	# };

	programs.fish.enable = true;

	fonts.fontconfig.defaultFonts.emoji = ["Noto Color Emoji" "Noto Emoji" "Twitter Color Emoji"];

	fonts.fonts = with pkgs; [
	noto-fonts-emoji
	twemoji-color-font
	];

	# services.kubernetes = {
	# 	masterAddress = "master.k8s.kitsu";
	# 	roles = ["master" "node"];
	# 	easyCerts = true;
	# };

	# qt5 = {
	# 	enable = true;
	# 	platformTheme = "gnome";
	# 	style = "adwaita";
	# };

	documentation.dev.enable = true;

	# https://github.com/NixOS/nixpkgs/pull/25311#issuecomment-431107258
	systemd.services.systemd-udev-settle.serviceConfig.ExecStart =
	["" "${pkgs.coreutils}/bin/true"];

	services.dbus.packages = [ pkgs.gnome3.dconf ];

	nix.trustedUsers = ["@wheel" "arnaud"];

	# This value determines the NixOS release with which your system is to be
	# compatible, in order to avoid breaking some software such as database
	# servers. You should change this only after NixOS release notes say you
	# should.
	system.stateVersion = "20.03";
	}
