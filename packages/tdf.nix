{
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  cairo,
  gtk3,
  poppler,
}:

rustPlatform.buildRustPackage {
  pname = "tdf";
  version = "unstable-2024-07-12";

  src = fetchFromGitHub {
    owner = "itsjunetime";
    repo = "tdf";
    rev = "main";
    # sha256 = "0000000000000000000000000000000000000000000000000000";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
  cargoSha256 = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ cairo gtk3 poppler ];
}
