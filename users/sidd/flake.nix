{
  description = "home-manager for a nixos system";

  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.neovim-nightly-overlay = {
    url = "github:nix-community/neovim-nightly-overlay";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.emacs-overlay = {
    url = "github:nix-community/emacs-overlay";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      overlays = [
        self.inputs.neovim-nightly-overlay.overlays.default
        self.inputs.emacs-overlay.overlay
      ];
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      homeConfigurations = {
        "sidd@codes" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {
              home = {
                username = "sidd";
                homeDirectory = "/home/sidd";
                stateVersion = "20.09";
              };

              nixpkgs.overlays = overlays;

              imports = [
                # ./modules/android.nix
                ./modules/home-manager.nix
                ./modules/chat.nix
                ./modules/nvim.nix
                ./modules/emacs
                ./modules/fish.nix
                ./modules/tmux.nix
                ./modules/direnv.nix
                ./modules/fonts.nix
                ./modules/general.nix
                ./modules/git.nix
                ./modules/i3.nix
                ./modules/languages.nix
                ./modules/media.nix
                ./modules/newsboat.nix
              ];
            }
          ];
        };
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };

  nixConfig = {
    extra-trusted-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
  };

}
