{

  description = "A very basic flake";
  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    zen-browser.url = "github:youwen5/zen-browser-flake";

  };

  outputs = inputs@{ self, nixpkgs, zen-browser }: {
    
    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {

      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./configuration.nix ];

    };

  };

}