{
  description = "My NixOs Home Assistant configuration for Raspberry Pi 3 Model B";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, hardware, sops-nix }: {
    nixosConfigurations.malina = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./configuration.nix
         
        hardware.nixosModules.raspberry-pi-3

        sops-nix.nixosModules.sops

        ./home-assistant.nix
      ];      
    };
  };
}
