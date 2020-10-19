{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-20.09";
    home-arnaud.url = "github:lightdiscord/home-arnaud";
    flat-remix.url = "github:lightdiscord/nix-flat-remix";
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
