{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat
    fzf
    jq
    htop
    btop # better htop (so much better)
    tree
    rclone
    p7zip
    tldr
    awscli2
    cloc
    lsd
    ripgrep

    vscode # society forces me to use it sometimes :(
    # (pkgs.callPackage ../packages/cisco.nix { })
    # jetbrains.clion

    # zoom-us
    # spotify
  ];
}
