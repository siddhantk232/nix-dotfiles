{
  description = "home-manager for a nixos system";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
  {
    homeConfigurations = {
      "sidd@legion" = home-manager.lib.homeManagerConfiguration {
        configuration = {pkgs, ...}: 
          {
            nixpkgs.config = import ./config/config.nix;
            imports = [
              ./modules/home-manager.nix
              ./modules/chat.nix
              ./modules/dev.nix
              ./modules/fonts.nix
              ./modules/general.nix
              ./modules/git.nix
              ./modules/i3.nix
              ./modules/languages.nix
              ./modules/media.nix
            ];
          };

        system = "x86_64-linux";
        homeDirectory = "/home/sidd";
        username = "sidd";
      };
    };
  };
}
