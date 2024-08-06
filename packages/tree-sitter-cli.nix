{ lib
, rustPlatform
, fetchFromGitHub
}:

rustPlatform.buildRustPackage rec {
  pname = "tree-sitter-cli";
  version = "0.22.6";

  src = fetchFromGitHub {
    owner = "tree-sitter";
    repo = "tree-sitter";
    rev = "v${version}";
    sha256 = "sha256-jBCKgDlvXwA7Z4GDBJ+aZc52zC+om30DtsZJuHado1s=";
  };

  cargoHash = "sha256-UbCcl8z0klUZBt8Z8siKcZ+/T2mtlTAfdf7WMDc0pWM=";

  cargoBuildFlags = [ "-p" "tree-sitter-cli" ];

  doCheck = false;
}
