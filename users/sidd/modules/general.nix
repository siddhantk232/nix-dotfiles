{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    google-chrome

    bat
    zathura
    fzf
    jq
    htop
    btop # better htop (so much better)
    tree
    feh
    rclone
    p7zip
    tldr
    awscli2
    arandr
    cloc

    vscode # society forces me to use it sometimes :(
    # (pkgs.callPackage ../packages/cisco.nix { })
    jetbrains.clion

    zoom-us
    # spotify
  ];

  xdg.configFile."zathura/zathurarc".text = builtins.readFile ../config/zathurarc;
}
