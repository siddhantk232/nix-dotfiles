{config, pkgs, libs, ...}:
{
  home.packages = with pkgs; [
    android-studio
    flutter
  ];
}
