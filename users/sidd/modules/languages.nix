{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    go_1_17
    nodejs-16_x
    haskellPackages.ghc
    gcc

    # Language servers
    nodePackages.typescript-language-server
    gopls
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
