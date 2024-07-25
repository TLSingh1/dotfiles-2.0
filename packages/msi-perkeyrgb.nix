{ lib, stdenv, fetchFromGitHub, python3Packages }:

python3Packages.buildPythonApplication rec {
  pname = "msi-perkeyrgb";
  version = "2.1";

  src = fetchFromGitHub {
    owner = "Askannz";
    repo = pname;
    rev = "master";
    sha256 = lib.fakeSha256; # You may need to update this
  };

  propagatedBuildInputs = with python3Packages; [ setuptools hidapi ];
}
