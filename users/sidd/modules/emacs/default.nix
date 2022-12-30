{pkgs, ...}:
let
  myEmacs = (pkgs.emacsWithPackagesFromUsePackage {
    config = ''
      (load-file "~/.config/emacs/init.el")
    '';
    defaultInitFile = true;
    package = pkgs.emacsPgtkNativeComp;
    alwaysEnsure = true;
  });
in
{
  programs.emacs = {
    enable = true;
    package = myEmacs;
  };
  xdg.configFile."emacs/init.el".source = ./init.el;
}
