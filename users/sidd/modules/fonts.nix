{ pkgs, config, home, ... }:
{
	fonts.fontconfig.enable = true;
	home.packages = [
		(pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
	];
}
