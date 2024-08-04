{ lib
, rustPlatform
, fetchCrate
}:

rustPlatform.buildRustPackage rec {
  pname = "tree-sitter-cli";
  version = "0.22.6";

  src = fetchCrate {
    inherit pname version;
    sha256 = lib.fakeSha256;
  };

  cargoSha256 = lib.fakeSha256;
}
