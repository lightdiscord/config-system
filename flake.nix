{
  description = "NixOS system configuration";

  inputs = {
    flat-remix.url = "github:lightdiscord/nix-flat-remix";
    home-arnaud.url = "github:lightdiscord/home-arnaud";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.ritsu = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs.flake-inputs = inputs;

      modules = [
        inputs.home-arnaud.nixosModules.nixos
        ./src/default.nix
      ];
    };

    # This way I keep steam out of my system configuration and I can update it through my profile.
    # But I extend it with the required libraries to run some games.
    packages.x86_64-linux.steam = nixpkgs.legacyPackages.x86_64-linux.steam.override {
      # This is what the base steam module on nixpkgs does.
      # Reference: https://github.com/NixOS/nixpkgs/blob/6e01aa7ca639260aa4c8e652656f132fd5bfeb19/nixos/modules/programs/steam.nix#L8-L13
      extraLibraries = pkgs: with self.nixosConfigurations.ritsu.config.hardware.opengl;
        [ package ] ++ extraPackages;
    };
  };
}
