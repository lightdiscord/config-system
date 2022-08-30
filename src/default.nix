{ flake-inputs, lib, config, pkgs, ... }:

{
  require = [
    ./hardware.nix
    ./docker.nix
  ];

  nix.extraOptions = ''
  experimental-features = nix-command flakes
  '';

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    cleanTmpDir = true;
  };

  networking = {
    hostName = "tower";
    networkmanager.enable = true;

    firewall = {
      logRefusedConnections = true;
      logRefusedPackets = true;
    };
  };

  time.timeZone = "Europe/Paris";

  environment.systemPackages = with pkgs; [
    vim git
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.opengl.enable = true;

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
