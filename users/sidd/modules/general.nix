{ pkgs, ... }:
{
	home.packages = with pkgs; [
		brave
		bat
		zathura
		fzf
		jq
		htop
		tree
	];	
}
