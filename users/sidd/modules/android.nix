{config, pkgs, libs, ...}:
{
  home.packages = with pkgs; [
    jdk
    android-studio
    dart
    flutter
  ];
}
