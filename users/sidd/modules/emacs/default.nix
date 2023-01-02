{ pkgs, ... }:
let
  myEmacs = (pkgs.emacsWithPackagesFromUsePackage {
    defaultInitFile = true;
    package = pkgs.emacsUnstable;
    alwaysEnsure = true;
    config = ''
      (load-file "~/.config/emacs/init.el")
    '';
    extraEmacsPackages = epkgs: with epkgs; [
      use-package
      evil
      evil-collection
      evil-commentary
      magit
    ];
  });
in
{
  programs.emacs = {
    enable = true;
    package = myEmacs;
  };

  home.packages = [
    pkgs.cantarell-fonts
  ];

  xdg.configFile."emacs/init.el".source = ./init.el;
}
