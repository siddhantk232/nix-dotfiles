{ config, pkgs, home, ... }:
{
  home.packages = with pkgs; [
    gitAndTools.delta
    gitAndTools.gh
  ];
  
  home.file.".gitconfig".text = builtins.readFile ../config/gitconfig;
}
