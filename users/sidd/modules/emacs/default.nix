{ pkgs, ... }:
let
  myEmacs = (pkgs.emacsWithPackagesFromUsePackage {
    defaultInitFile = true;
    package = pkgs.emacsUnstable;
    alwaysEnsure = true;
    config = ''
      (load-file "~/.config/emacs/init.el")
    '';
  });
in
{
  programs.emacs = {
    enable = true;
    package = myEmacs;
  };

  home.packages = with pkgs; [
    cantarell-fonts
    fd
    imagemagick
  ];

  xdg.configFile."emacs/init.el".source = ./init.el;
}
