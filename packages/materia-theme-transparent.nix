{ stdenv, fetchFromGitHub, meson, ninja, dart-sass, gnome, gtk-engine-murrine }:

stdenv.mkDerivation {
  pname = "materia-theme-transparent";
  version = "unstable-2024-06-29";

  src = fetchFromGitHub {
    owner = "ckissane";
    repo = "materia-theme-transparent";
    rev = "c5d95bbddd59a717bfc4976737af429a89ba74e0";
    sha256 = "sha256-SuBt3DOVgxZdkcKWMysDF5S4A4y/VHZwRUmvtx8w52s=";
  };

  nativeBuildInputs = [ meson ninja dart-sass ];

  propagatedUserEnvPkgs = [ 
    gnome.gnome-themes-extra 
    gtk-engine-murrine
  ];

  mesonFlags = [
    "-Dcolors=default,dark"
    "-Dsizes=default,compact"
  ];
}
