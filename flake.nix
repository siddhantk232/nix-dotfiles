{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  # inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }: {

    nixosConfigurations.codes = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./nixos/configuration.nix ];
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}
