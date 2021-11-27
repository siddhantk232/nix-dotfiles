{ config, pkgs, libs, ... }:
{
	home.stateVersion = "20.09";
	programs.home-manager.enable = true;
	home.packages = with pkgs; [
		lxappearance
		xclip
		gnome.gnome-screenshot
		scrot
		networkmanagerapplet
		pavucontrol
		playerctl
    lsd
	];
	
	home.sessionVariables = {
		EDITOR = "nvim";
	};
}
