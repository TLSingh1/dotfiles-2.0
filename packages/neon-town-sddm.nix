{ stdenv, fetchurl }:

stdenv.mkDerivation {
  pname = "neon-town-sddm";
  version = "unstable-2024-07-14";

  src = fetchurl {
    url = "https://store.kde.org/p/1323349/"
  };

  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/sddm/themes/neon-town
    cp -r * $out/share/sddm/themes/neon-town  
  '';
}
