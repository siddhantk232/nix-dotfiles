{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    gitAndTools.delta
    gitAndTools.gh
  ];
}
