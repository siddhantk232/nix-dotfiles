{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    go
    gcc
    nodejs-16_x
    haskellPackages.ghc
    dart
    flutter

    # Language servers
    nodePackages.typescript-language-server
    gopls
    clang-tools
    haskell-language-server
    solargraph
    nodePackages.pyright
    terraform-lsp
    nodePackages.bash-language-server
    nodePackages.vscode-json-languageserver
    nodePackages.svelte-language-server
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    texlab
  ];
}
