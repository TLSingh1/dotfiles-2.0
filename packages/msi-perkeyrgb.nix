{ lib, stdenv, fetchFromGitHub, python3Packages }:

python3Packages.buildPythonApplication rec {
  pname = "msi-perkeyrgb";
  version = "2.1";

  src = fetchFromGitHub {
    owner = "Askannz";
    repo = pname;
    rev = "master";
    sha256 = "sha256-QG+Kchoy+kbg32EF0psnoowvmEVKnfIOsMcxR569RTg=";
  };

  propagatedBuildInputs = with python3Packages; [ setuptools hidapi ];
}
