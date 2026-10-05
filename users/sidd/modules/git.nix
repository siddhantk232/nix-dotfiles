{ config, pkgs, home, ... }:
{
  home.packages = with pkgs; [
    delta
    gh
  ];

  home.file.".gitconfig".text = builtins.readFile ../config/gitconfig;
}
