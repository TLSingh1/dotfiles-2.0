{ stdenv }:

stdenv.mkDerivation {
  pname = "neon-town-sddm";
  version = "unstable-2024-07-14";

  src = ../modules/home-manager/gui/sddm/neontown.tar.gz;

  installPhase = ''
    mkdir -p $out/share/sddm/themes/neon-town
    cp -r . $out/share/sddm/themes/neon-town
  '';
}
