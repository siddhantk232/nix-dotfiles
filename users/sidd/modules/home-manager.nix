{ config, pkgs, libs, ... }:
{

	home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "vim";
    PAGER = "less -FirSwX";
    MANPAGER = "less -FirSwX";
  };

	home.stateVersion = "20.09";
	programs.home-manager.enable = true;
}
