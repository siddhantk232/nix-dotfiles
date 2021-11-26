{ pkgs, ... }:
{
	xsession.windowManager.i3 = {
		enable = true;
		configFile = ../config/i3/config;
	};	
}
