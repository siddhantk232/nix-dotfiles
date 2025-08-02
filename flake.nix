{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, nixpkgs-unstable, home-manager, ... }:
    let
      overlays = [
        self.inputs.neovim-nightly-overlay.overlays.default
        self.inputs.emacs-overlay.overlay
      ];
    in
    {

      nixosConfigurations.codes = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./nixos/configuration.nix ];
      };

      darwinConfigurations."fifthtrys-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./ft_mac/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.users.siddhant = {
              nixpkgs.overlays = overlays;
              nixpkgs.config.allowUnfree = true;
              nixpkgs.config.allowBroken = true;
              imports = [
                ./ft_mac/home.nix
                ./users/sidd/modules/git.nix
                ./users/sidd/modules/direnv.nix
                ./users/sidd/modules/fish.nix
                ./users/sidd/modules/fonts.nix
                ./users/sidd/modules/general.nix
                ./users/sidd/modules/languages.nix
                ./users/sidd/modules/media.nix
                ./users/sidd/modules/newsboat.nix
                ./users/sidd/modules/nvim.nix
                # ./users/sidd/modules/emacs
                ./users/sidd/modules/tmux.nix
              ];
            };

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;
    };
}
