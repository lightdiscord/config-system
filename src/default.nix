{ flake-inputs, lib, config, pkgs, ... }:

{
  require = [
    ./hardware
  ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

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

  services.upower.enable = true;

  console.keyMap = "fr";
  i18n.defaultLocale = "en_US.UTF-8";

  time.timeZone = "Europe/Paris";

  environment.systemPackages = with pkgs; [
    vim git
    flake-inputs.flat-remix.packages.x86_64-linux.icon-theme
    flake-inputs.flat-remix.packages.x86_64-linux.gtk-theme
  ];

  sound.enable = true;

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };

  services.xserver = {
    enable = true;
    layout = "fr";
    videoDrivers = [ "nvidia" ];
    libinput.additionalOptions = ''MatchIsTouchpad "on"'';
    xkbVariant = "azerty";
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = false;
    exportConfiguration = true;
  };

  programs.light.enable = true;

  users.groups."plugdev" = {};

  services.xserver.displayManager.sessionCommands = config.services.xserver.displayManager.setupCommands;

  users.users.arnaud = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "plugdev" "network" "video" "vboxusers" "docker" "libvirtd" "adbusers" ];
    shell = pkgs.fish;
    packages = [ pkgs.qgnomeplatform ];
  };

  boot.kernelModules = ["kvm-intel"];

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

  hardware.openrazer.enable = true;

  fonts.fontconfig.enable = true;
  # fonts.fontconfig.defaultFonts.emoji = ["Noto Color Emoji" "Noto Emoji" "Twitter Color Emoji"];

  fonts.fonts = with pkgs; [
    hack-font
    noto-fonts-emoji
    twemoji-color-font
    cantarell-fonts
  ];

  # qt5 = {
  # 	enable = true;
  # 	platformTheme = "gnome";
  # 	style = "adwaita";
  # };

  documentation.dev.enable = true;

  services.xserver.desktopManager.gnome3.enable = true;
  # https://github.com/NixOS/nixpkgs/pull/25311#issuecomment-431107258
  systemd.services.systemd-udev-settle.serviceConfig.ExecStart = ["" "${pkgs.coreutils}/bin/true"];
  systemd.services.systemd-networkd-wait-online.serviceConfig.ExecStart = ["" "${pkgs.coreutils}/bin/true"];

  services.gnome3.gnome-keyring.enable = lib.mkForce false;
  services.dbus.packages = [ pkgs.gnome3.dconf ];

  nix.trustedUsers = ["@wheel" "arnaud"];

  programs.adb.enable = true;
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03";

  networking.firewall.logRefusedConnections = true;
  networking.firewall.logRefusedPackets = true;
  services.avahi.enable = true;
}
