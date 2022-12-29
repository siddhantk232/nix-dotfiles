{
  description = "home-manager for a nixos system";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

  outputs = { self, nixpkgs, home-manager, ... }: 
  let 
    overlays = [
      self.inputs.neovim-nightly-overlay.overlay
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
                # ./modules/dev.nix
                ./modules/fish.nix
                ./modules/tmux.nix
                # ./modules/direnv.nix
                ./modules/fonts.nix
                ./modules/general.nix
                ./modules/git.nix
                ./modules/i3.nix
                # ./modules/languages.nix
                ./modules/media.nix
                ./modules/newsboat.nix
              ];
            }
        ];
      };
    };
  };
}
