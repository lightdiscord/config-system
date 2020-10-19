{
  description = "NixOS system configuration";

  inputs = {
    flat-remix.url = "github:lightdiscord/nix-flat-remix";
    home-arnaud.url = "github:lightdiscord/home-arnaud";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-20.09";
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
  };
}
