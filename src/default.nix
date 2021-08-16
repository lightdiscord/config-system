{ flake-inputs, lib, config, pkgs, ... }:

{
  require = [
    ./hardware
  ];

  hardware.sane.extraBackends = [
    pkgs.sane-airscan
    pkgs.hplipWithPlugin
  ];

  hardware.sane.enable = true;
  virtualisation.docker.enable = true;

  services.flatpak.enable = true;

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes ca-references
    '';
  };

  # services.unclutter.enable = true;

  services.gnome3.gnome-keyring.enable = true;
  networking.networkmanager.enable = true;

  services.udisks2.enable = true;

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
    cleanTmpDir = true;
  };

  # hardware.xpadneo.enable = true;

  networking = {
    hostName = "ritsu";
    useNetworkd = true;
    useDHCP = false;
  };

  hardware.bluetooth.enable = true;

  systemd.network = {
    enable = true;
    networks."40-ether" = {
      matchConfig.Type = "ether";
      DHCP = "yes";
    };

    networks."40-wlan" = {
      matchConfig.Type = "wlan";
      DHCP = "yes";
      linkConfig.RequiredForOnline = "no";
    };
  };

  # services.picom = {
  #   enable = true;
  # };
  # services.upower.enable = true;

  console.keyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";

  time.timeZone = "Europe/Paris";

  environment.systemPackages = with pkgs; [
    vim git
    slock
#    flake-inputs.flat-remix.packages.x86_64-linux.icon-theme
#    flake-inputs.flat-remix.packages.x86_64-linux.gtk-theme
  ];

  sound.enable = true;

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };

  services.xserver = {
    enable = true;
    layout = "us";
    videoDrivers = [ "nvidia" ];
    # videoDrivers = [ "intel" ];
    libinput.additionalOptions = ''MatchIsTouchpad "on"'';
    # displayManager.startx.enable = true;
    # Using lightdm because nvidia driver fail when using gdm
    # displayManager.lightdm.enable = true;
    displayManager.sddm.enable = true;
    # displayManager.sessionCommands = config.services.xserver.displayManager.setupCommands;
    # displayManager.gdm.enable = true;
    # displayManager.gdm.wayland = false;
    desktopManager.plasma5.enable = true;
    # desktopManager.gnome3.enable = true;

    #displayManager.gdm.wayland = false;
    #windowManager.i3.enable = true;
    exportConfiguration = true;
  };

  programs.light.enable = true;

  users.groups."plugdev" = {};

  users.users.arnaud = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "plugdev" "network" "video" "vboxusers" "docker" "libvirtd" "adbusers" "audio" "scanner" "lp" ];
    shell = pkgs.fish;
    packages = [ pkgs.qgnomeplatform ];
  };

  services.pcscd.enable = true;

  services.udev.packages = with pkgs; [
    yubikey-personalization
    libu2f-host
    android-udev-rules
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  nixpkgs.config.allowUnfree = true;

  location = {
    latitude = 48.85341;
    longitude = 2.3488;
  };

  programs.fish.enable = true;

  #hardware.openrazer.enable = true;

  fonts = {
    fonts = [
      pkgs.ubuntu_font_family
      pkgs.hack-font
      pkgs.noto-fonts-emoji
      pkgs.twemoji-color-font
      pkgs.cantarell-fonts
	  pkgs.jetbrains-mono
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Ubuntu"];
        sansSerif = ["Ubuntu"];
        monospace = ["Ubuntu"];
      };
    };
  };
  # fonts.fontconfig.defaultFonts.emoji = ["Noto Color Emoji" "Noto Emoji" "Twitter Color Emoji"];

  # qt5 = {
  # 	enable = true;
  # 	platformTheme = "gnome";
  # 	style = "adwaita";
  # };

  documentation.dev.enable = true;

  # services.xserver.desktopManager.gnome3.enable = true;
  systemd.services.systemd-networkd-wait-online.serviceConfig.ExecStart = ["" "${pkgs.coreutils}/bin/true"];

  services.dbus.packages = [ pkgs.gnome3.dconf ];

  nix.trustedUsers = ["@wheel" "arnaud"];

  programs.adb.enable = true;
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09";

  networking.firewall.allowedTCPPorts = [8000];
  networking.firewall.allowedUDPPorts = [8000];
  networking.firewall.logRefusedConnections = true;
  networking.firewall.logRefusedPackets = true;
  services.avahi.enable = true;
}
