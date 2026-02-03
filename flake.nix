{
  description = "My NixOs Home Assistant configuration for Raspberry Pi 3 Model B";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = { self, nixpkgs, hardware, ... }@inputs: {
    nixosConfigurations = {
      "malina" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };

        modules = [
          ./configuration.nix
          hardware.nixosModules.raspberry-pi-3
        ];
      };
    };
  };
}
