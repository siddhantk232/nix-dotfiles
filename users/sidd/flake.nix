{
  description = "home-manager for a nixos system";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.telescope-fzf-native = {
    url = "github:nvim-telescope/telescope-fzf-native.nvim";
    flake = false;
  };

  outputs = { self, nixpkgs, home-manager }: 
  let 
    overlays = [
      (self: super: {
        telescope-fzf-native = super.callPackage ./packages/telescope-fzf-native.nix {src = super.inputs.telescope-fzf-native;};
      })
    ];
  in
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
