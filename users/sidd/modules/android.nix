{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    jdk
    jetbrains.idea-community
    android-studio
    flutter
    dart
  ];
}
