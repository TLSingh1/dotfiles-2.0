{ lib
, rustPlatform
, fetchCrate
}:

rustPlatform.buildRustPackage rec {
  pname = "tree-sitter-cli";
  version = "unstable-2024-08-04";

  src = fetchCrate {
    inherit pname version;
    sha256 = lib.fakeSha256;
  };

  cargoSha256 = lib.fakeSha256;
}
