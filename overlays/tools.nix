{inputs, ...}: final: prev: {
  tree-sitter-cli = final.callPackage ../packages/tree-sitter-cli.nix {};
  # msi-perkeyrgb = final.callPackage ../packages/msi-perkeyrgb.nix {};
}
