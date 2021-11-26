{ pkgs, ... }:
{
	home.packages = with pkgs; [
		brave
		steam

		bat
		zathura
		fzf
		jq
		htop
		tree
	];	
}
