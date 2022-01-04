{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    go_1_17
    nodejs-16_x
    haskellPackages.ghc
    gcc
    python310

    # Language servers
    clang-tools
    nodePackages.typescript-language-server
    gopls
    haskell-language-server
    solargraph
    nodePackages.pyright
    terraform-lsp
    nodePackages.bash-language-server
    nodePackages.svelte-language-server
    nodePackages.vscode-langservers-extracted
    texlab
  ];
}
