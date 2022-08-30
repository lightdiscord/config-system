{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.tower = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs.flake-inputs = inputs;

      modules = [
        ./src/default.nix
      ];
    };

    # Keeping steam out of the system configuration while adding the needed extra packages to it.
    packages.x86_64-linux.steam = nixpkgs.legacyPackages.x86_64-linux.steam.override {
      # This is what the base steam module on nixpkgs does.
      # Reference: https://github.com/NixOS/nixpkgs/blob/6e01aa7ca639260aa4c8e652656f132fd5bfeb19/nixos/modules/programs/steam.nix#L8-L13
      extraLibraries = pkgs: with self.nixosConfigurations.tower.config.hardware.opengl;
      [ package ] ++ extraPackages;
    };
  };
}
