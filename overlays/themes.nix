{inputs, ...}: final: prev: {
  materia-theme-transparent = prev.callPackage ../packages/materia-theme-transparent.nix {};
  neon-town-sddm = prev.callPackage ../packages/neon-town-sddm.nix {};
}
